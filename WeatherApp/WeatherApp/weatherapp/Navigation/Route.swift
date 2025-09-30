//
//  Route.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import Foundation

enum Route: Hashable {
    case hourly(date: Date, allHourly: [HourlyRowViewData], title: String)

    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case let (.hourly(ldate, _, ltitle), .hourly(rdate, _, rtitle)):
            return ldate == rdate && ltitle == rtitle
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case let .hourly(date, _, title):
            hasher.combine(date)
            hasher.combine(title)
        }
    }
}
