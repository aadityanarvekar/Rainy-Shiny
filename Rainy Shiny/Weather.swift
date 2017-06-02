//
//  Weather.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/26/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Weather {
    private var _cityName: String!
    var cityName: String {
        get {
            return _cityName != nil && _cityName.characters.count > 0 ? _cityName : ""
        }
        
        set {
            _cityName = newValue
        }
    }
    
    private var _date: Date!
    var date: Date {
        return _date
    }
    
    var dateAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            if _date == nil {
                return dateFormatter.string(from: Date())
            } else {
                return dateFormatter.string(from: _date)
            }
        }
    }
    
    
    private var _weatherType: String!
    var weatherType: String {
        get {
            return _weatherType != nil && _weatherType.characters.count > 0 ? _weatherType : ""
        }
        
        set {
            _weatherType = newValue
        }
    }
    
    private var _weatherTypeId: Int!
    var weatherTypeId: Int {
        get {
            return _weatherTypeId == nil ? 0 : _weatherTypeId
        }
        
        set {
            _weatherTypeId = newValue
        }
    }
    
    
    private var _currentTemp: Double!
    var currentTemp: Double {
        get {
            return _currentTemp
        }
        set {
            _currentTemp = newValue
        }
    }
    
    private var _minTemp: Double!
    var minTemp: Double {
        get {
            return _minTemp
        }
        set {
            _minTemp = newValue
        }
    }
    
    private var _maxTemp: Double!
    var maxTemp: Double {
        get {
            return _maxTemp
        }
        set {
            _maxTemp = newValue
        }
    }
    
    init(cityName: String, weatherType: String, currentTemp: Double) {
        _cityName = cityName
        _weatherType = weatherType
        _currentTemp = currentTemp
    }
    
    convenience init() {
        self.init(cityName: "Vienna", weatherType: "Sunny", currentTemp: 35)
    }
    
    func downloadCurrentDayWeather(completed: @escaping WeatherDownloadComplete) {
        let currentDayWeatherUrl = getWeatherUrl(lat: currentLocationLatitude, lon: currentLocationLongitude)
        URLSession.shared.dataTask(with: currentDayWeatherUrl) { (data: Data?, response: URLResponse?, err: Error?) in
            if (err == nil && data != nil) {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let dict = jsonData as? Dictionary<String, Any> {
                        
                        // Date
                        if let dt = dict["dt"] as? Int {
                            print("Current Date: \(dt)")
                            self.setCurrentDate(utcTimeInSeconds: dt)
                        }
                        
                        // City Name
                        if let name = dict["name"] as? String {
                            print("City Name: \(name)")
                            self.cityName = name
                        }
                        
                        // Weather Type & Weather Type Id
                        if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                            if let description = weather[0]["description"] as? String {
                                print("Weather Type: \(description.capitalized)")
                                self.weatherType = description.capitalized
                            }
                            
                            if let id = weather[0]["id"] as? Int {
                                print("Weather Type ID: \(id)")
                                self.weatherTypeId = id
                            }
                        }
                        
                        // Current Temp, Min Temp & Max Temp
                        if let main = dict["main"] as? Dictionary<String, Any> {
                            if let currentTemp = main["temp"] as? Double {
                                print("Current Temperature: \(currentTemp)")
                                self.currentTemp = self.roundToSingleDecimal(num: currentTemp)
                            }
                            
                            if let minTemp = main["temp_min"] as? Double {
                                print("Min Temperature: \(minTemp)")
                            }
                            
                            if let maxTemp = main["temp_max"] as? Double {
                                print("Min Temperature: \(maxTemp)")
                            }                            
                            
                        }
                        
                    }
                    
                    // Completion Handler
                    completed()
                
                } catch let err as NSError {
                    print("Error getting JSON data from data: \(err.debugDescription)")
                }
            } else {
                print("Error Downloading Data for current day: \(err.debugDescription)")
            }
        }.resume()
    }
    
    func roundToSingleDecimal(num: Double) -> Double {
        return Double(round(num * 10)/10)
    }
    
    func setCurrentDate(utcTimeInSeconds: Int) {
        _date = Date(timeIntervalSince1970: Double(utcTimeInSeconds))
    }
    
    func getWeekdayFromDate() -> String {
        let weekDay = Calendar.current.component(.weekday, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        return dateFormatter.weekdaySymbols[weekDay - 1].capitalized
    }
    
}
