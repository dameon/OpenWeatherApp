//
//  GetWeahterData.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import UIKit

class GetWeahterData: UIViewController {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    private let openWeatherMapAPIKey = "c5be46e0fd913db5fb370221ee81a4e1"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeather(city: String) {
        
        // This is a pretty simple networking task, so the shared session will do.
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
                                print("Data:\n\(data!)")
            }
        })
        
        // The data task is set up...now go!!
        dataTask.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
