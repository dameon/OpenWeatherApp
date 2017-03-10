//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import Foundation

struct Weather {
    
//    let dateAndTime: NSDate
    
    let city: String
//    let country: String
//    let longitude: Double
//    let latitude: Double
    
//    let weatherID: Int
//    let mainWeather: String
//    let weatherDescription: String
//    let weatherIconID: String
    
    private let temp: Double
    var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    var tempFahrenheit: Double {
        get {
            return (temp - 273.15) * 1.8 + 32
        }
    }

    init(weatherData: [String: AnyObject]) {
        city = weatherData["name"] as! String
        let mainDict = weatherData["main"] as! [String: AnyObject]
        temp = mainDict["temp"] as! Double

    }
    
}

