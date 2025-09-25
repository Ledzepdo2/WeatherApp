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

    func start() {
        // Ruta inicial
        if path.isEmpty {
            path = [.main]
        }
    }

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
        path.append(.main)
    }
}

