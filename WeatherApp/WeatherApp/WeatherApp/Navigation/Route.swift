//
//  Route.swift
//  WeatherApp
//
//  Created by Jesus Perez on 24/09/2025
//

import Foundation

enum Route: Hashable {
    case main
    case detail(id: UUID)
}
