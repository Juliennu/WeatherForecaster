//
//  ForeCaster.swift
//  WeatherForecaster
//
//  Created by Yukinaga2 on 2017/12/06.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class Forecaster: NSObject {
    
    static func forecast(cityName:String, completion:@escaping (ForecastResult)->Void){
        
        let appID = "9a93273903e4b79b1e15a62a5d41330c"
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
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                completion(result)
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
}

struct ForecastResult: Codable{
    var list:[Forecast]
}
//struct Iconresult: Codable {
//    var icon
//}

struct Forecast: Codable {
    var dt_txt:String
    var main:Main
    var weather:[Weather]
    
    struct Main: Codable {
        var temp: Double
        var pressure: Int
        var humidity: Int
    }
    
    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
        var icon: String
    }
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp)
    }
    func getFormattedHumidity() -> String {
        return String("Humidity: \(main.humidity) %")
    }
    func getFormattedPressure() -> String {
        //3桁区切りでカンマ,を挿入
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let formattedNumber = formatter.string(from: NSNumber.init(integerLiteral: main.pressure))
        
        return formattedNumber! + " hPa"
    }
    
    func getDescription() -> String{
        return weather.count > 0 ? weather[0].description : "" // 三項演算子
    }
//    
//    func getIcon() -> UIImageView {
//        
//        let iconURLString = "http://openweathermap.org/img/wn/" + weather[0].icon + "@2x.png"
//        
//        let url = URL(string: iconURLString ?? "")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//        do {
//            let data = try Data(contentsOf: url!)
//            let uiImage = UIImage(data: data)
//            if let uiImageView = UIImageView(image: uiImage) {
//            return uiImageView
//            }
//        } catch let err {
//            print("イメージアイコンの取得に失敗しました。\(err)")
//        }
//        }
//        task.resume()
        



        
//
////        return weather.count > 0 ? weather[0].icon : ""
//
//
//    }
    func getIconText() -> String {
        if weather.count == 0 {
            return ""
        }
        // 次を参考: https://openweathermap.org/weather-conditions
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }

    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
    }
}
