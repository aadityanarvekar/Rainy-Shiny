//
//  SixDayForecast.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/28/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import Foundation

class SixDayForecast {
    var sixDayForecast: [Weather] = []
    
    func downloadWeatherForecast(completed: @escaping WeatherDownloadComplete) {        
        let forecastWeatherUrl = getWeatherForecastUrl(lat: currentLocationLatitude, lon: currentLocationLongitude, count: 7)
        URLSession.shared.dataTask(with: forecastWeatherUrl) { (data: Data?, response: URLResponse?, err: Error?) in
            if (err == nil && data != nil) {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let dict = jsonData as? Dictionary<String, Any> {
                        if let list = dict["list"] as? [Dictionary<String, Any>] {
                            for var i in 1 ... list.count - 1 {
                                let tempWeather = Weather()
                                
                                // Date for weather forecast
                                if let dt = list[i]["dt"] as? Int {
                                    print("Date for forecast: \(dt)")
                                    tempWeather.setCurrentDate(utcTimeInSeconds: dt)
                                }
                                
                                // Min and Max Temp
                                if let temp = list[i]["temp"] as? Dictionary<String, Any> {
                                    if let minTemp = temp["min"] as? Double {
                                        print("Min Temp for Day \(i): \(minTemp)")
                                        tempWeather.minTemp = self.roundToSingleDecimal(num: minTemp)
                                    }
                                    
                                    if let maxTemp = temp["max"] as? Double {
                                        print("Max Temp for Day \(i): \(maxTemp)")
                                        tempWeather.maxTemp = self.roundToSingleDecimal(num: maxTemp)
                                    }
                                }
                                
                                // Weather Type & ID
                                if let weather = list[i]["weather"] as? [Dictionary<String, Any>] {
                                    if let weatherType = weather[0]["main"] as? String {
                                        print("Weather Type for Day \(i): \(weatherType)")
                                        tempWeather.weatherType = weatherType.capitalized
                                    }
                                    
                                    if let id = weather[0]["id"] as? Int {
                                        print("Weather Type ID: \(id)")
                                        tempWeather.weatherTypeId = id
                                    }
                                }
                                
                                // Add weather to sixDayForecast
                                self.sixDayForecast.append(tempWeather)
                            }
                            completed()
                        }
                    }
                } catch let err as NSError {
                    print("Error getting JSON from forecast Data: \(err.debugDescription)")
                }
            } else {
                print("Error downloading weather forecast: \(err.debugDescription)")
            }
        }.resume()
    }
    
    func numberOfDaysIncludedInForecast() -> Int {
        return sixDayForecast.count
    }
    
    func roundToSingleDecimal(num: Double) -> Double {
        return Double(round(num * 10)/10)
    }
    
    func getWeatherForDayByIndex(index: Int) -> Weather {
        return sixDayForecast[index]
    }
}
