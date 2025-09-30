//
//  HourlyViewModel.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import Foundation
import Combine

@MainActor
final class HourlyViewModel: ObservableObject {
    @Published private(set) var rows: [HourlyRowViewData] = []
    let title: String

    init(day: Date, allHourly: [HourlyRowViewData], title: String) {
        self.title = title
        let cal = Calendar(identifier: .gregorian)
        self.rows = allHourly
            .filter { cal.isDate($0.date, inSameDayAs: day) }
            .sorted { $0.date < $1.date }
    }
}
