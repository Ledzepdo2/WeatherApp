//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by JESUS PEREZ MOJICA on 06/07/22.
//

import Foundation
import UIKit

let data = """
"{
    "coord": {
        "lon": -99.1667,
        "lat": 19.2833
    },
    "weather": [
        {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 291.1,
        "feels_like": 290.62,
        "temp_min": 290.13,
        "temp_max": 291.27,
        "pressure": 1028,
        "humidity": 64
    },
    "visibility": 8047,
    "wind": {
        "speed": 2.57,
        "deg": 30
    },
    "clouds": {
        "all": 75
    },
    "dt": 1657123691,
    "sys": {
        "type": 2,
        "id": 2040357,
        "country": "MX",
        "sunrise": 1657109027,
        "sunset": 1657156723
    },
    "timezone": -18000,
    "id": 3515428,
    "name": "Tlalpan",
    "cod": 200
}
""".data(using: .utf8)


// MARK: - WeatherModel
struct WeatherModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}



let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: data!)


weatherModel?.coord


