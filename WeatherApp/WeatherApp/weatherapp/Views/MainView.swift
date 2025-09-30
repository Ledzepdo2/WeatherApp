//
//  MainView.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI

struct MainView: View {
    @StateObject var vm: MainViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        content
            .navigationTitle("Weather (Daily)")
            .onAppear { vm.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle, .loading:
            ProgressView("Cargando…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .error(msg):
            VStack(spacing: 12) {
                Text("Error").font(.headline)
                Text(msg).multilineTextAlignment(.center)
                Button("Reintentar") { vm.onAppear() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .loaded(dailies, _):
            List(dailies) { day in
                HStack {
                    VStack(alignment: .leading) {
                        Text(day.date, style: .date).font(.headline)
                        Text("Min \(Int(day.min))°  ·  Max \(Int(day.max))°")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: WeatherIcon.from(code: day.weatherCode).rawValue)
                        .imageScale(.large)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    let title = DateFormatter.localizedString(from: day.date, dateStyle: .medium, timeStyle: .none)
                    let rows = vm.hourlyFor(day: day.date)
                    coordinator.showHourly(for: day.date, hourly: rows, title: title)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    RootView().environmentObject(AppCoordinator())
}
