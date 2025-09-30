//
//  WeatherCode.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import Foundation

enum WeatherIcon: String {
    case clear = "sun.max"
    case cloudy = "cloud"
    case rain = "cloud.rain"
    case thunder = "cloud.bolt.rain"
    case snow = "snowflake"
    case fog = "cloud.fog"

    static func from(code: Int) -> WeatherIcon {
        switch code {
        case 0: return .clear
        case 1,2,3: return .cloudy
        case 45,48: return .fog
        case 51,53,55,56,57,61,63,65,66,67,80,81,82: return .rain
        case 71,73,75,77,85,86: return .snow
        case 95,96,99: return .thunder
        default: return .cloudy
        }
    }
}
