//
//  HourlyDetailView.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import SwiftUI

struct HourlyDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var vm: HourlyViewModel

    var body: some View {
        List(vm.rows) { row in
            HStack {
                VStack(alignment: .leading) {
                    Text(row.date, style: .time).font(.headline)
                    Text("S. térmica \(Int(row.apparent))° · Nubes \(Int(row.cloudCover))%")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Text("\(Int(row.temperature))°")
                    .font(.title3).monospacedDigit()
            }
            .padding(.vertical, 4)
        }
        .navigationTitle(vm.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Cerrar") { coordinator.pop() }
            }
        }
    }
}
