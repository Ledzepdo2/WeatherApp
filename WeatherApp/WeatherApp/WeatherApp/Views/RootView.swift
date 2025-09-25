//
//  RootView.swift
//  WeatherApp
//
//  Created by Jesus Perez on 24/09/2025
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MainView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainView()
                    case .detail(let id):
                        DetailView(itemID: id)
                    }
                }
        }
        .onAppear { coordinator.start() }
    }
}
#Preview {
    RootView().environmentObject(AppCoordinator())
}
