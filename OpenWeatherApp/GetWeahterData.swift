//
//  GetWeahterData.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import UIKit

    // Mark: Delegates
protocol WeatherGetterDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)
}

class GetWeahterData {
    
    // Mark: Properties
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "c5be46e0fd913db5fb370221ee81a4e1"
    private var delegate: WeatherGetterDelegate
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    func getWeatherByCity(city: String) {
        let weatherRequestURL = (string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")
        getWeather(city: weatherRequestURL)
    }
    
    // Mark: WeatherGetter
    func getWeather(city: String) {
        
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        let weatherRequest = NSURLRequest(url: weatherRequestURL)

        // make the request
        let dataTask = session.dataTask(with: weatherRequest as URLRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            if let error = error {
                                // Case 1: Error
                                print("Error:\n\(error)")
                            }
                            else {
                                // Case 2: Success
                do {
                let weatherData =  try JSONSerialization.jsonObject(
                    with: data!,
                    options: .mutableContainers) as! [String: AnyObject]
                
                let weather = Weather(weatherData: weatherData)
                self.delegate.didGetWeather(weather: weather)
                    
                print("City: \(weatherData["name"]!)")
                print("Temperature: \(weatherData["main"]!["temp"]!!)")
                }
                catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    print("JSON error description: \(jsonError.description)")
                }
            }
        })
        
        // The data task is set up...now go!!
        dataTask.resume()
    }

}
