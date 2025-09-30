//
//  MainViewModel.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
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

