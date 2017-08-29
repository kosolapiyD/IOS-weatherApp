//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Dmitriy on 16/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import Alamofire
// ------ UIview weather variables ------- ///
class CurrentWeather {
    var cityName: String?
    var weatherType: String?
    var currentTemp: Double?
    
    var date: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }
    
// ----------- Alamofire download one day current weather ----------- //
    func downloadCurrentWeather(completed: @escaping DownloadComplete) {
        
        var urlString = ""
        if let city = Location.sharedInstance.cityName{
            urlString = String("\(BASE_URL_CURRENT)\(CITY)\(city)\(APP_ID_KEY)")!
        } else {
            urlString = String(CURRENT_WEATHER_URL)!
        }
        
        Alamofire.request(urlString).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String {
                    self.cityName = name.capitalized
                } else {
                    self.cityName = nil
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self.weatherType = main.capitalized
                    } else {
                        self.weatherType = nil
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToCelsius = (currentTemperature - 273.15)
                        self.currentTemp = kelvinToCelsius
                    } else {
                        self.currentTemp = nil
                    }
                }
            }
            completed()
        }
    }
}














































