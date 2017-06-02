//
//  Constants.swift
//  Rainy Shiny
//
//  Created by AADITYA NARVEKAR on 5/26/17.
//  Copyright © 2017 Aaditya Narvekar. All rights reserved.
//

import Foundation

/** Sample URL
 http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1
 api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}
 **/
let API_KEY = "02de1521bfbb993fabb31d90f441d7d3"

let BASE_URL_Single_DAY_WEATHER = "http://api.openweathermap.org/data/2.5/weather?units=metric&"
let BASE_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&"

let APP_ID = "&appid="
let LATITUDE = "lat="
let LONGITUTDE = "&lon="
let COUNT = "&cnt="

var currentLocationLatitude: String = "38.9064300"
var currentLocationLongitude: String = "-77.2227180"

func getWeatherUrl(lat: String, lon: String) -> URL {
    return URL(string: "\(BASE_URL_Single_DAY_WEATHER)\(LATITUDE)\(lat)\(LONGITUTDE)\(lon)\(APP_ID)\(API_KEY)")!
}

func getWeatherForecastUrl(lat: String, lon: String, count: Int) -> URL {
    return URL(string: "\(BASE_URL_FORECAST)\(LATITUDE)\(lat)\(LONGITUTDE)\(lon)\(APP_ID)\(API_KEY)\(COUNT)\(count)")!
}

typealias WeatherDownloadComplete = () -> ()
