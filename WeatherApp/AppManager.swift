//
//  AppManager.swift
//  WeatherApp
//
//  Created by hackeru on 20/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import Alamofire

class AppManager: NSObject {
    static let manager = AppManager()
    
    func getForecastFor(city : String? = nil, completion : @escaping ([Forecast])->Void){
        
        var urlString = ""
        if let city = city{
            urlString = "\(BASE_URL_DAYS)\(CITY)\(city)\(DAYS)\(APP_ID_KEY)"
        } else {
            urlString = FORECAST_URL
        }
        
        Alamofire.request(urlString).responseJSON { response in
            
            guard let dict = response.result.value as? [String: Any] else{
                completion([])
                return
            }
            
            guard let list = dict["list"] as? [[String: Any]] else{
                completion([])
                return
            }
            
            var forecasts : [Forecast] = []
            
            for obj in list {
                let forecast = Forecast(weatherDict: obj)
                forecasts.append(forecast)
            }
            // show the next day in a list, not the current
            forecasts.removeFirst()
            
            completion(forecasts)
        }
        
    }
    
}
















