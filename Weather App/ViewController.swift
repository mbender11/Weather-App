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

