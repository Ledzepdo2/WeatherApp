//
//  DetailView.swift
//  WeatherApp
//
//  Created by Jesus Perez on 24/09/2025
//

import SwiftUI

struct DetailView: View {
    let itemID: UUID

    var body: some View {
        VStack(spacing: 16) {
            Text("Detalle")
                .font(.title2)
            Text("ID: \(itemID.uuidString)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Detalle")
    }
}
#Preview {
    DetailView(itemID: UUID())
}
