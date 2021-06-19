//
//  ForeCaster.swift
//  WeatherForecaster
//
//  Created by Yukinaga2 on 2017/12/06.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class Forecaster: NSObject {
    
    static func forecast(cityName:String, completion:@escaping ([String:Any])->Void){
        
        let appID = "347ac8f1962a843838d26d1f3a1c8912"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=" + cityName + "&APPID=" + appID
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
                guard let jsonDic = json as? [String:Any] else {
                    print("JSON is not a dictionary")
                    return
                }
                completion(jsonDic)
            }catch{
                print("Serialize error")
            }
            
        }
        task.resume()
        
    }
}

struct  {
    <#fields#>
}
