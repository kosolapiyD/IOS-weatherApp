//
//  Location.swift
//  WeatherApp
//
//  Created by Dmitriy on 17/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import CoreLocation


class Location {
    // singleton class
    static var sharedInstance = Location()
    
    var latitude: Double!
    var longitude: Double!
    
    var cityName: String!
}













