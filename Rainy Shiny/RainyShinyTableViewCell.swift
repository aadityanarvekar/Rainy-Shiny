//
//  RainyShinyTableViewCell.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/24/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import UIKit

class RainyShinyTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherConditionImg: UIImageView!
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var weatherConditionLbl: UILabel!
    @IBOutlet weak var maximumTempLbl: UILabel!
    @IBOutlet weak var minimumTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureRainyShinyCell(weather: Weather) {
        
        currentDayLbl.text = weather.getWeekdayFromDate()
        weatherConditionLbl.text = weather.weatherType
        minimumTempLbl.text = "\(weather.roundToSingleDecimal(num: weather.minTemp))°C"
        maximumTempLbl.text = "\(weather.roundToSingleDecimal(num: weather.maxTemp))°C"
        setWeatherImageLblForCell(weather: weather)
        
    }
    
    func setWeatherImageLblForCell(weather: Weather) {
        var img: UIImage!
        switch weather.weatherTypeId {
        case 801...803:
            img = UIImage(named: "PartiallyCloudyMini.png")
            break
            
        case 800:
            img = UIImage(named: "ClearMini.png")
            break
            
        case 300...531:
            img = UIImage(named: "RainMini.png")
            break
            
        case 200...232:
            img = UIImage(named: "ThunderstormMini.png")
            break
            
        case 600...622:
            img = UIImage(named: "SnowMini.png")
            break
            
        default:
            img = UIImage(named: "CloudsMini.png")
        }
        
        weatherConditionImg.image = img
        
    }
}
