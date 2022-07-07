//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by JESUS PEREZ MOJICA on 06/07/22.
//

import Foundation
import UIKit

struct WeatherManager {
    // MARK: - Fetch URL
    func FetchURL(city : String) {
        //0. URL Strings
        let apiKey : String = "54d3457a0d217bd650b3858b90dfb9a6"
        let urlString : String = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey
        PerformRequest(urlString: urlString)
    }
    // MARK: - Request URL
    func PerformRequest(urlString : String) {
        //1.Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give URLSession a task
            let task = session.dataTask(with: url, completionHandler: handleMetod)
            
            //4. Start the task
            task.resume()
        }
        //5. Handler metod
        func handleMetod(data: Data?, response: URLResponse?, error: Error?) {
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                //let dataString = String(data: safeData, encoding: .utf8) *usar unicamente si se requiere
                // print(dataString!)
                self.parseJson(weatherData: safeData)
                
            }
        }
    }
    
    
    //Recordar Agregar en el safeData -> self.parseJson(weatherData: safeData)
    func parseJson(weatherData : Data) {
        //JSON Decoder instance
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherModel.self, from: weatherData)
            print(decodeData.main.tempMax)
        } catch {
            print(error)
        }
    }
}
