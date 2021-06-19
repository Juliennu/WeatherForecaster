//
//  DetailViewController.swift
//  WeatherForecaster
//
//  Created by Yukinaga2 on 2017/12/05.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var forecast:Forecast?
    
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var iconLabel:UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var descLabel:UILabel!
    @IBOutlet var tempLabel:UILabel!
    @IBOutlet var humidityLabel:UILabel!
    @IBOutlet var pressureLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateLabel.text = forecast?.dt_txt
//        iconImage = forecast?.getIcon()
        iconLabel.text = forecast?.getIconText()
        weatherLabel.text = forecast?.getMain()
        descLabel.text = forecast?.getDescription()
        tempLabel.text = forecast?.getFormattedTemp()
        humidityLabel.text = forecast?.getFormattedHumidity()
        pressureLabel.text = forecast?.getFormattedPressure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
