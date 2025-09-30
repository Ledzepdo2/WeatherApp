//
//  Route.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import Foundation

enum Route: Hashable {
    case hourly(date: Date, allHourly: [HourlyRowViewData], title: String)
}
