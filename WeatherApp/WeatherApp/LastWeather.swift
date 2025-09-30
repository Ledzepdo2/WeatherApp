//
//  Item.swift
//  WeatherApp
//
//  Created by Jesus Perez on 20/09/25.
//

// LastWeather.swift
import Foundation
import SwiftData

@Model final class LastWeather {
    @Attribute(.unique) var id: String = "singleton"
    var updatedAt: Date
    init(updatedAt: Date) { self.updatedAt = updatedAt }
}
