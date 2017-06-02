//
//  WeatherVC.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/22/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var currentWeatherConditionImg: UIImageView!
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    
    var currentWeather: Weather!
    var sixDayForecast: SixDayForecast!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWeatherUi()
        
        // Set current Location
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        } else {
            print("Location Service Disabled. Providing Weather for Tysons Corner")
            updateWeatherUi()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = locations.last?.coordinate.latitude {
            currentLocationLatitude = "\(lat)"
        }
        
        if let long = locations.last?.coordinate.longitude {
            currentLocationLongitude = "\(long)"
        }
        
        updateWeatherUi()

    }
    
    private func updateWeatherUi() {
        currentWeather = Weather()
        sixDayForecast = SixDayForecast()
        
        
        // Current Day Weather
        currentWeather.downloadCurrentDayWeather {
            // Initialize UI
            DispatchQueue.main.async {
                self.currentTempLbl.text = "\(self.currentWeather.currentTemp)°C"
                self.currentDateLbl.text = self.currentWeather.dateAsString
                self.currentLocationLbl.text = self.currentWeather.cityName
                self.currentWeatherTypeLbl.text = self.currentWeather.weatherType
                self.setCurrentWeatherConditionImg()
            }
        }
        
        // 6-Day Forecast
        sixDayForecast.downloadWeatherForecast {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "rainyShinyCell") as? RainyShinyTableViewCell {
            cell.configureRainyShinyCell(weather: sixDayForecast.getWeatherForDayByIndex(index: indexPath.row))
            return cell
        } else {
            print("Error: Incorrect cell")
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sixDayForecast == nil ? 0 : sixDayForecast.numberOfDaysIncludedInForecast()        
    }
    
    func setCurrentWeatherConditionImg() {
        var img: UIImage!
        switch currentWeather.weatherTypeId {
        case 801...803:
            img = UIImage(named: "PartiallyCloudy.png")
            break
            
        case 800:
            img = UIImage(named: "Clear.png")
            break
            
        case 300...531:
            img = UIImage(named: "Rain.png")
            break
            
        case 200...232:
            img = UIImage(named: "Thunderstorm.png")
            break
            
        case 600...622:
            img = UIImage(named: "Snow.png")
            break
            
        default:
            img = UIImage(named: "Clouds.png")
        }
        
        currentWeatherConditionImg.image = img
        
    }
}

