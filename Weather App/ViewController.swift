//
//  ViewController.swift
//  Weather App
//
//  Created by Mason Bender on 2/22/18.
//  Copyright © 2018 Mason Bender. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var weather: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        var message = ""
        // TODO: Fix error handling for when the user enters a city that doesn't exist. For some erason that isn't working correctly
        if city.text!.count > 0 {
            let url = URL(string: "https://www.weather-forecast.com/locations/" + city.text!.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ".", with: "") + "/forecasts/latest")!
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print(error)
                } else {
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeparator = "</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                        if let dataArray = dataString?.components(separatedBy: stringSeparator) {
                            if dataArray.count > 0 {
                                stringSeparator = "</span>"
                                let newDataArray = dataArray[1].components(separatedBy: stringSeparator)
                                if newDataArray.count > 0 {
                                    // to get degree symbol on mac: option+shift+8
                                    message = newDataArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                            }
                        }
                    }
                }
                if message == "" {
                    message = "Unable to find the weather in that city. Please try again."
                }
                DispatchQueue.main.sync(execute: {
                    self.weather.text = message
                })
            }
            task.resume()
        } else {
            self.weather.text = "No city entered. Please try again."
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

