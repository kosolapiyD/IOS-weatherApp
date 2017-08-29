//
//  DetailWeatherViewController.swift
//  WeatherApp
//
//  Created by Dmitriy on 25/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import Alamofire

class DetailWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailImage: String?
    var detailCity: String?
    var detailType: String?
    
    var detailForecasts = [DetailForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        downloadDetailForecastData {
            self.updateUI()
        }

    }
    
    func updateUI() {
        cityLabel.text! = detailCity!
        typeLabel.text! = detailType!
        imageView.image = UIImage(named: detailType! + "2")
    }

    //MARK: - tableView methods ------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "detailForecastCell", for: indexPath) as? DetailForecastCell {
            
            let detailForecast = detailForecasts[indexPath.row]
            cell.configureDetailCell(detailForecast: detailForecast)
            return cell
        } else {
            return DetailForecastCell()
        }
    }

    func downloadDetailForecastData(completed: @escaping DownloadComplete) {
        
        let detailForecastURL = URL(string: DETAIL_HOURS_FORECAST)!
        
        Alamofire.request(detailForecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    
                    for obj in list {
                        let detailForecast = DetailForecast(detailForecastDict: obj)
                        self.detailForecasts.append(detailForecast)
                    }
                    //self.detailForecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

}
