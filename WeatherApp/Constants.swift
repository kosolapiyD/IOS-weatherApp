//
//  Constants.swift
//  WeatherApp
//
//  Created by Dmitriy on 16/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import Foundation


let BASE_URL_CURRENT = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_DAYS = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let CITY = "q="
let DAYS = "&cnt=16"


let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID_KEY = "&appid=2be7df40deb484484670de1748596543"



typealias DownloadComplete = () -> ()

// current day
let CURRENT_WEATHER_URL = "\(BASE_URL_CURRENT)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID_KEY)"

// 16 days
let FORECAST_URL = "\(BASE_URL_DAYS)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(DAYS)\(APP_ID_KEY)"

//let DETAIL_HOURS_FORECAST = "http://api.openweathermap.org/data/2.5/forecast?q=Ashdod&appid=2be7df40deb484484670de1748596543"
let DETAIL_HOURS_FORECAST = "http://api.openweathermap.org/data/2.5/forecast?q=\(Location.sharedInstance.cityName!)&cnt=9&appid=2be7df40deb484484670de1748596543"















































