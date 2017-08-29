//
//  Forecast.swift
//  WeatherApp
//
//  Created by Dmitriy on 16/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit

// ----- 16 days forecast ------ //
class Forecast {
    
    var date: String?
    var weatherType: String?
    var highTemperature: String?
    var lowTemperature: String?
    
    //MARK: forecast init()
    init(weatherDict: Dictionary<String, Any>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToCelsius = (min - 273.15)
                self.lowTemperature = String(format: "%.f", kelvinToCelsius) + "°c"
            } else {
                self.lowTemperature = nil
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToCelsius = (max - 273.15)
                self.highTemperature = String(format: "%.f", kelvinToCelsius) + "°c"
            } else {
                self.highTemperature = nil
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            
            if let main = weather[0]["main"] as? String {
                self.weatherType = main
            } else {
                self.weatherType = nil
            }
        }
        
        if let timestamp = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: timestamp)
            self.date = unixConvertedDate.dayOfTheWeek()
        } else {
            self.date = nil
        }
        
    }
    
}
//MARK: extension for the day of the week
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}



























