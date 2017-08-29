//
//  DetailForecast.swift
//  WeatherApp
//
//  Created by Dmitriy on 25/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import Alamofire

class DetailForecast {
    
    var detailTemp: String?
    var detailHumidity: String?
    var detailDescription: String?
    var detailWindSpeed: String?
    var detailTime: String?
    
    init(detailForecastDict: Dictionary<String, Any>) {
        
        if let main = detailForecastDict["main"] as? Dictionary<String, Any> {
            
            if let temp = main["temp"] as? Double {
                
                let kelvinToCelsius = (temp - 273.15)
                self.detailTemp = "temp   " + String(format: "%.f", kelvinToCelsius) + "°c"
            } else {
                self.detailTemp = nil
            }
            
            if let humidity = main["humidity"] as? Double {
                self.detailHumidity = "hum " + String(humidity) + "%"
            } else {
                self.detailHumidity = nil
            }
        }
        
        if let weather = detailForecastDict["weather"] as? [Dictionary<String, Any>] {
            
            if let description = weather[0]["description"] as? String {
                
                self.detailDescription = description.capitalized
            } else {
                self.detailDescription = nil
            }
        }
        
        if let wind = detailForecastDict["wind"] as? Dictionary<String, Any> {
            
            if let speed = wind["speed"] as? Double {
                
                self.detailWindSpeed = "wind   " + String(speed)
            } else {
                self.detailWindSpeed = nil
            }
        }
        
        if let time = detailForecastDict["dt_txt"] as? String {
            self.detailTime = time
        } else {
            self.detailTime = nil
        }
    }
}
