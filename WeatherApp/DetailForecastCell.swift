//
//  DetailForecastCell.swift
//  WeatherApp
//
//  Created by Dmitriy on 26/04/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit

class DetailForecastCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    func configureDetailCell(detailForecast: DetailForecast) {
        
        timeLabel.text = detailForecast.detailTime
        descriptionLabel.text = detailForecast.detailDescription
        tempLabel.text = detailForecast.detailTemp
        humidityLabel.text = detailForecast.detailHumidity
        windLabel.text = detailForecast.detailWindSpeed
    }
    
}
