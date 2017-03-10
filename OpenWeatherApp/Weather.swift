//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import Foundation

struct Weather {
    
    let city: String
    let weatherIconID: String
    
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
        
        let weatherDict = weatherData["weather"]![0] as! [String: AnyObject]
        weatherIconID = weatherDict["icon"] as! String
    }
    
}

