//
//  Weatherservices.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import Foundation
import OpenMeteoSdk

protocol WeatherServicing {
    func fetch(lat: Double, lon: Double, forecastDays: Int) async throws -> WeatherDataDTO
}

struct WeatherService: WeatherServicing {
    func fetch(lat: Double, lon: Double, forecastDays: Int) async throws -> WeatherDataDTO {
        let dailyFields = [
          "uv_index_max","temperature_2m_max","temperature_2m_min",
          "apparent_temperature_max","apparent_temperature_min","weather_code",
          "sunrise","sunset","daylight_duration","sunshine_duration",
          "wind_speed_10m_max","rain_sum","snowfall_sum","showers_sum",
          "precipitation_hours","precipitation_sum","precipitation_probability_max",
          "shortwave_radiation_sum"
        ].joined(separator: ",")

        let hourlyFields = [
          "temperature_2m","relative_humidity_2m","dew_point_2m","apparent_temperature",
          "precipitation_probability","rain","precipitation","showers","snowfall",
          "snow_depth","pressure_msl","surface_pressure","cloud_cover",
          "cloud_cover_low","cloud_cover_mid","cloud_cover_high","visibility",
          "evapotranspiration","soil_temperature_54cm","wind_speed_80m","temperature_80m"
        ].joined(separator: ",")

        let urlStr = """
        https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)\
        &daily=\(dailyFields)&hourly=\(hourlyFields)&forecast_days=\(forecastDays)\
        &format=flatbuffers
        """
        let url = URL(string: urlStr)!
        let responses = try await WeatherApiResponse.fetch(url: url)
        let response = responses[0]

        let hourly = response.hourly!
        let daily = response.daily!
        let offset = response.utcOffsetSeconds

        let dto = WeatherDataDTO(
            hourly: .init(
                time: hourly.getDateTime(offset: offset),
                temperature2m: hourly.variables(at: 0)!.values,
                relativeHumidity2m: hourly.variables(at: 1)!.values,
                dewPoint2m: hourly.variables(at: 2)!.values,
                apparentTemperature: hourly.variables(at: 3)!.values,
                precipitationProbability: hourly.variables(at: 4)!.values,
                rain: hourly.variables(at: 5)!.values,
                precipitation: hourly.variables(at: 6)!.values,
                showers: hourly.variables(at: 7)!.values,
                snowfall: hourly.variables(at: 8)!.values,
                snowDepth: hourly.variables(at: 9)!.values,
                pressureMsl: hourly.variables(at: 10)!.values,
                surfacePressure: hourly.variables(at: 11)!.values,
                cloudCover: hourly.variables(at: 12)!.values,
                cloudCoverLow: hourly.variables(at: 13)!.values,
                cloudCoverMid: hourly.variables(at: 14)!.values,
                cloudCoverHigh: hourly.variables(at: 15)!.values,
                visibility: hourly.variables(at: 16)!.values,
                evapotranspiration: hourly.variables(at: 17)!.values,
                soilTemperature54cm: hourly.variables(at: 18)!.values,
                windSpeed80m: hourly.variables(at: 19)!.values,
                temperature80m: hourly.variables(at: 20)!.values
            ),
            daily: .init(
                time: daily.getDateTime(offset: offset),
                uvIndexMax: daily.variables(at: 0)!.values,
                temperature2mMax: daily.variables(at: 1)!.values,
                temperature2mMin: daily.variables(at: 2)!.values,
                apparentTemperatureMax: daily.variables(at: 3)!.values,
                apparentTemperatureMin: daily.variables(at: 4)!.values,
                weatherCode: daily.variables(at: 5)!.values,
                sunrise: daily.variables(at: 6)!.valuesInt64,
                sunset: daily.variables(at: 7)!.valuesInt64,
                daylightDuration: daily.variables(at: 8)!.values,
                sunshineDuration: daily.variables(at: 9)!.values,
                windSpeed10mMax: daily.variables(at: 10)!.values,
                rainSum: daily.variables(at: 11)!.values,
                snowfallSum: daily.variables(at: 12)!.values,
                showersSum: daily.variables(at: 13)!.values,
                precipitationHours: daily.variables(at: 14)!.values,
                precipitationSum: daily.variables(at: 15)!.values,
                precipitationProbabilityMax: daily.variables(at: 16)!.values,
                shortwaveRadiationSum: daily.variables(at: 17)!.values
            ),
            latitude: Double(response.latitude),
            longitude: Double(response.longitude),
            utcOffsetSeconds: response.utcOffsetSeconds
        )
        return dto
    }
}
