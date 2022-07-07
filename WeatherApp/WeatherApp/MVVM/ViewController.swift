//
//  ViewController.swift
//  WeatherApp
//
//  Created by JESUS PEREZ MOJICA on 06/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label : UILabel!
    
    let weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "\(weatherManager.FetchURL(city: "Tlalpan"))"
        
    }


}

