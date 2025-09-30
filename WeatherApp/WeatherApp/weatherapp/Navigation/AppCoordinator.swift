//
//  AppCoordinator.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path: [Route] = []

    func showHourly(for day: Date, hourly: [HourlyRowViewData], title: String) {
        path.append(.hourly(date: day, allHourly: hourly, title: title))
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll() // Vuelve al MainView porque RootView siempre lo fija
    }

    func reset() {
        path = []
    }
}
