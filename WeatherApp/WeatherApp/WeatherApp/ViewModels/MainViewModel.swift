//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Jesus Perez on 24/09/2025
//

import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @Published private(set) var state: String = "idle"

    func load() async {
        // Llama servicios async/await aquí
        self.state = "loaded"
    }
}

