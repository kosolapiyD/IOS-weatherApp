//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Dmitriy on 16/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        lowTempLabel.text = forecast.lowTemperature
        highTempLabel.text = forecast.highTemperature
        weatherTypeLabel.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType!)
        dayLabel.text = forecast.date
        
        // descriptionLabel.text = forecast.description
    }
    
}
