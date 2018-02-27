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
        
        if city.text!.count > 0 {
            // TODO: Handle periods in city names. Not entirely sure how openweathermaps.org handles periods in city names such as for Washington D.C., can't seem to find it.
            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + city.text!.replacingOccurrences(of: " ", with: "+") + "&units=imperial&appid=539ab870116f53af64fd720cab33e79a")
            var cityName = city.text!
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(jsonResult)
                            print(jsonResult["name"])
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                print(description)
                                message = "Weather in " + cityName + ": " + description
                            }
                            // TODO: Fix this to add temperature to the weather label
//                            if let temperature = (jsonResult["main"] as? NSDictionary)?["temp"] as? String {
//                                print(temperature)
//                                message += "\nWith a temperature of: " + temperature + "°"
//                            }
                        } catch {
                            print("JSON call failed")
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
            self.weather.text = "No city entered. Please enter a city."
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

