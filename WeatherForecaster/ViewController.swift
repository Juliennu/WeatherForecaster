//
//  ViewController.swift
//  WeatherForecaster
//
//  Created by Yukinaga2 on 2017/12/05.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var forecasts = [Forecast]()
    
    @IBOutlet var weatherTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Forecaster.forecast(cityName: "tokyo") { (result) in
            self.forecasts = result.list
            DispatchQueue.main.async { // メインスレッドで実行
                self.weatherTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detaiVC = segue.destination as? DetailViewController {
            detaiVC.forecast = sender as? Forecast
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        let timeLabel = cell.viewWithTag(1) as? UILabel
        timeLabel?.text = forecasts[indexPath.row].dt_txt
        
//        var iconImage = cell.viewWithTag(3) as? UIImageView
//        iconImage = forecasts[indexPath.row].getIcon()
        let iconLabel = cell.viewWithTag(2) as? UILabel
        iconLabel?.text = forecasts[indexPath.row].getIconText()

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MainToDetail", sender: forecasts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

