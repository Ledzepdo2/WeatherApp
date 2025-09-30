//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Jesus Perez on 20/09/25.
//

import XCTest
import CoreLocation
import Combine
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    // MARK: - Helpers

    private func makeMockWeatherData() -> WeatherDataDTO {
        let now = Date()
        return WeatherDataDTO(
            hourly: .init(
                time: [now],
                temperature2m: [25.0],
                relativeHumidity2m: [40.0],
                dewPoint2m: [10.0],
                apparentTemperature: [27.0],
                precipitationProbability: [0.0],
                rain: [0.0],
                precipitation: [0.0],
                showers: [0.0],
                snowfall: [0.0],
                snowDepth: [0.0],
                pressureMsl: [1013.0],
                surfacePressure: [1010.0],
                cloudCover: [20.0],
                cloudCoverLow: [10.0],
                cloudCoverMid: [5.0],
                cloudCoverHigh: [5.0],
                visibility: [10000.0],
                evapotranspiration: [0.0],
                soilTemperature54cm: [20.0],
                windSpeed80m: [5.0],
                temperature80m: [25.0]
            ),
            daily: .init(
                time: [now],
                uvIndexMax: [3.0],
                temperature2mMax: [30.0],
                temperature2mMin: [20.0],
                apparentTemperatureMax: [31.0],
                apparentTemperatureMin: [19.0],
                weatherCode: [0.0],
                sunrise: [0], // Int64
                sunset: [0],  // Int64
                daylightDuration: [43200.0],   // 12h en segundos
                sunshineDuration: [36000.0],   // 10h en segundos
                windSpeed10mMax: [15.0],
                rainSum: [0.0],
                snowfallSum: [0.0],
                showersSum: [0.0],
                precipitationHours: [0.0],
                precipitationSum: [0.0],
                precipitationProbabilityMax: [0.0],
                shortwaveRadiationSum: [0.0]
            ),
            latitude: 10.0,
            longitude: 20.0,
            utcOffsetSeconds: 0
        )
    }

    // MARK: - Tests

    @MainActor
    func testMainViewModel_loadsWeatherSuccessfully() async throws {
        // Arrange
        let location = MockLocationService()
        location.mockLocation = CLLocation(latitude: 10.0, longitude: 20.0)

        let weather = MockWeatherService()
        weather.mockData = makeMockWeatherData()

        let sut = MainViewModel(location: location, weather: weather)

        // Act
        await sut.load(lat: 10.0, lon: 20.0)

        // Assert
        guard case let .loaded(dailies, hourly) = sut.state else {
            return XCTFail("Expected .loaded state, got \(sut.state)")
        }
        XCTAssertEqual(dailies.count, 1)
        XCTAssertEqual(hourly.count, 1)
        XCTAssertEqual(dailies.first?.max, 30.0)
        XCTAssertEqual(hourly.first?.temperature, 25.0)
    }
}
