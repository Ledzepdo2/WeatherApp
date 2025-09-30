//
//  WeatherData.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import Foundation

struct WeatherDataDTO { // lo que sale del servicio
    let hourly: Hourly
    let daily: Daily
    let latitude: Double
    let longitude: Double
    let utcOffsetSeconds: Int32

    struct Hourly {
        let time: [Date]
        let temperature2m: [Float]
        let relativeHumidity2m: [Float]
        let dewPoint2m: [Float]
        let apparentTemperature: [Float]
        let precipitationProbability: [Float]
        let rain: [Float]
        let precipitation: [Float]
        let showers: [Float]
        let snowfall: [Float]
        let snowDepth: [Float]
        let pressureMsl: [Float]
        let surfacePressure: [Float]
        let cloudCover: [Float]
        let cloudCoverLow: [Float]
        let cloudCoverMid: [Float]
        let cloudCoverHigh: [Float]
        let visibility: [Float]
        let evapotranspiration: [Float]
        let soilTemperature54cm: [Float]
        let windSpeed80m: [Float]
        let temperature80m: [Float]
    }

    struct Daily {
        let time: [Date]
        let uvIndexMax: [Float]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
        let apparentTemperatureMax: [Float]
        let apparentTemperatureMin: [Float]
        let weatherCode: [Float]
        let sunrise: [Int64]
        let sunset: [Int64]
        let daylightDuration: [Float]
        let sunshineDuration: [Float]
        let windSpeed10mMax: [Float]
        let rainSum: [Float]
        let snowfallSum: [Float]
        let showersSum: [Float]
        let precipitationHours: [Float]
        let precipitationSum: [Float]
        let precipitationProbabilityMax: [Float]
        let shortwaveRadiationSum: [Float]
    }
}

struct DailyRowViewData: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let min: Float
    let max: Float
    let weatherCode: Int
}

struct HourlyRowViewData: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let temperature: Float
    let apparent: Float
    let precipitationProb: Float
    let cloudCover: Float

    static func == (lhs: HourlyRowViewData, rhs: HourlyRowViewData) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
