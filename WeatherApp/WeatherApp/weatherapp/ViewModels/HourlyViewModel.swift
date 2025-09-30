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
    @Published private(set) var day: Date
    let title: String

    private let allHourly: [HourlyRowViewData]
    private let calendar: Calendar

    init(day: Date,
         allHourly: [HourlyRowViewData],
         title: String,
         calendar: Calendar = .current) {
        self.day = calendar.startOfDay(for: day)
        self.allHourly = allHourly
        self.title = title
        self.calendar = calendar
        self.updateRows()
    }

    /// Permite actualizar el día y recalcular el filtrado
    func setDay(_ newDay: Date) {
        self.day = calendar.startOfDay(for: newDay)
        updateRows()
    }

    /// Recalcula las filas filtradas y ordenadas
    private func updateRows() {
        self.rows = allHourly
            .filter { calendar.isDate($0.date, inSameDayAs: day) }
            .sorted { $0.date < $1.date }
    }
}
