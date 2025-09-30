//
//  App.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
    @StateObject private var coordinator = AppCoordinator()

    private let locationService: LocationServicing = LocationService()
    private let weatherService: WeatherServicing = WeatherService()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                MainView(vm: .init(location: locationService, weather: weatherService))
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case let .hourly(date, allHourly, title):
                            HourlyDetailView(vm: .init(day: date, allHourly: allHourly, title: title))
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
