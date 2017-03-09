//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weather = GetWeahterData()
        weather.getWeather(city: "Detroit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

