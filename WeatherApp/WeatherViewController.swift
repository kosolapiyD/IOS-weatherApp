//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitriy on 16/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    // instance of currentWeather ( 1 day UIView )
    var currentWeather: CurrentWeather!

    // forecsts array we using in tableView to update cells
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // not all the like google maps
        locationManager.stopMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        // forecast = Forecast() // actually an empty Forecast class we can use
        
        
    }
    
    // to run before we downloaded weather details
    // this runs before the view load
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Location.sharedInstance.cityName == nil {
            locationAuthStatus()
        } else {
            return
        }
    }
    
    
    //MARK: - Location authorization method
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location // if authorized save our location to currentLocation - var // instantiate
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude // saving each individual value // now it's saved in singleton class
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            // call for current day weather details
            currentWeather.downloadCurrentWeather {
            //Setup UI to load downloaded data
                self.downloadForecastData()
            }
        } else {
            locationManager.requestWhenInUseAuthorization() // if not authorized
            locationAuthStatus()
        }
    }
    
    
    
    //MARK: - API Methods
    
    // Alamofire downloading 16 days forecast weather data for TableView
    func downloadForecastData() {
        
        AppManager.manager.getForecastFor { (arr) in
            self.forecasts = arr
            self.tableView.reloadData()
            self.updateMainUI()
        }
    }
    
    // Alamofire downloading 16 days forecast weather data by city name for TableView
    func downloadForecastDataByCityName() {
        
        AppManager.manager.getForecastFor(city: Location.sharedInstance.cityName) { (arr) in
            self.forecasts = arr
            self.tableView.reloadData()
            self.updateMainUI()
        }
    }
    
    //MARK: - tableView methods ------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row] //go trough the forecasts array
            cell.configureCell(forecast: forecast) // and pass data to cells
            return cell
        } else {
            return WeatherCell() // in case we got nothing return empty cell
        }
    }
    
    // updating UIView with downloaded data for one day current weather
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTemperatureLabel.text = String(format: "%.f", currentWeather.currentTemp!) + "°c"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        // currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        let backgroundImg = UIImage(named: "earth2")!
        upperView.layer.contents = backgroundImg.cgImage
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let input = searchBar.text!
        forecasts.removeAll() // clean the tableView before show new data
        Location.sharedInstance.cityName = input.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        searchBar.text?.removeAll()
        currentWeather.downloadCurrentWeather {
            self.downloadForecastDataByCityName()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailForecast" {
            let detailWeatherViewController = segue.destination as! DetailWeatherViewController
            
            //let myIndexPath = self.tableView.indexPathForSelectedRow!
            //let detailForecast = forecasts[myIndexPath.row]
            
            detailWeatherViewController.detailType = currentWeather.weatherType
            detailWeatherViewController.detailCity = currentWeather.cityName
            Location.sharedInstance.cityName = currentWeather.cityName!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        }
    }
}
















