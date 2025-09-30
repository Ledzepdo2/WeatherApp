//
//  MockLocationService.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import Foundation
import CoreLocation
@testable import WeatherApp
import Combine

final class MockLocationService: LocationServicing {
    var locationUpdates = PassthroughSubject<CLLocation, Never>().eraseToAnyPublisher()
    var mockLocation: CLLocation?

    func requestWhenInUseAuthorization() {}

    func requestOneShotLocation() async throws -> CLLocation {
        if let loc = mockLocation { return loc }
        throw NSError(domain: "MockLocationService", code: 1)
    }
}

final class MockWeatherService: WeatherServicing {
    var mockData: WeatherDataDTO?

    func fetch(lat: Double, lon: Double, forecastDays: Int) async throws -> WeatherDataDTO {
        if let data = mockData { return data }
        throw NSError(domain: "MockWeatherService", code: 1)
    }
}
