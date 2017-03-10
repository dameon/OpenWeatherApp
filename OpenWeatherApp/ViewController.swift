//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Dameon Bryant on 3/9/17.
//  Copyright © 2017 Don't Quit On Yourself LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherGetterDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    var weather: GetWeahterData!
    private var openWeatherImageURL = "http://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather = GetWeahterData (delegate: self)
        
        let userInfo = UserDefaults.standard
        if let city = userInfo.string(forKey: "lastCitySearch") {
            cityTextField.text = city
            getWeatherByCity(self)
        }
        
        clearUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func getWeatherByCity(_ sender: Any) {
        guard let text = cityTextField.text, !text.isEmpty else {
            return
        }
        weather.getWeather(city: cityTextField.text!.urlEncoded)
    }
    
    // MARK: Keyboard Stuff
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getWeatherByCity(getCityWeatherButton)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         view.endEditing(true)
    }
    
    
    // MARK: - Utility methods
    // -----------------------
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .default,
            handler: nil
        )
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
        )
}

    func clearUI(){
        cityTextField.text = ""
        temperatureLabel.text = ""
    }
    
    // MARK: - Delegate methods
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.temperatureLabel.text = "\(Int(round(weather.tempCelsius)))°"
            
            let imageURL = URL(string: self.openWeatherImageURL.appending(weather.weatherIconID).appending(".png"))
            if let data = try? Data(contentsOf: imageURL!){
            self.weatherImage.image = UIImage(data: data)
            }
    }
}
    
    func didNotGetWeather(error: NSError) {
        DispatchQueue.main.async {
            self.showAlert(title: "Can't get the weather",
                                 message: "Oops, something went wrong, try again later.")
        }
        print("didNotGetWeather error: \(error)")
    }
}

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed)!
    }
}
