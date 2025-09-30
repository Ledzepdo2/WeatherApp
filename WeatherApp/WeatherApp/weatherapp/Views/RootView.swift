//
//  RootView.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: AppCoordinator

    // Inyectamos dependencias aquí
    private let locationService: LocationServicing = LocationService()
    private let weatherService: WeatherServicing = WeatherService()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MainView(vm: MainViewModel(location: locationService,
                                       weather: weatherService))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .hourly(date, allHourly, title):
                        HourlyDetailView(vm: HourlyViewModel(day: date,
                                                             allHourly: allHourly,
                                                             title: title))
                    }
                }
        }
    }
}

#Preview {
    RootView().environmentObject(AppCoordinator())
}
