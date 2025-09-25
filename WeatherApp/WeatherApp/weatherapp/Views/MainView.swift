//
//  MainView.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Estado: \(viewModel.state)")
            HStack {
                Button("Cargar") {
                    Task { await viewModel.load() }
                }
                Button("Ir a detalle") {
                    coordinator.push(.detail(id: UUID()))
                }
            }
        }
        .padding()
        .navigationTitle("Inicio")
    }
}
#Preview {
    RootView().environmentObject(AppCoordinator())
}
