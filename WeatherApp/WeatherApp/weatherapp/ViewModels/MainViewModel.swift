//
//  MainViewModel.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import Foundation
import Combine
import CoreLocation

@MainActor
final class MainViewModel: ObservableObject {
    enum State {
        case idle, loading, loaded([DailyRowViewData], hourly: [HourlyRowViewData]), error(String)
    }

    @Published private(set) var state: State = .idle

    private let location: LocationServicing
    private let weather: WeatherServicing
    private var bag = Set<AnyCancellable>()

    // Cache para hourly completo del primer día (para navegación)
    private var latestHourly: [HourlyRowViewData] = []

    init(location: LocationServicing, weather: WeatherServicing) {
        self.location = location
        self.weather = weather
    }

    func onAppear() {
        location.requestWhenInUseAuthorization()

        // Suscripción a cambios de ubicación (Combine)
        location.locationUpdates
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates { $0.coordinate.latitude == $1.coordinate.latitude &&
                                 $0.coordinate.longitude == $1.coordinate.longitude }
            .sink { [weak self] loc in
                Task { await self?.load(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude) }
            }
            .store(in: &bag)

        Task { // one-shot para el arranque
            do {
                let loc = try await location.requestOneShotLocation()
                await load(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
            } catch {
                state = .error("No se pudo obtener la ubicación: \(error.localizedDescription)")
            }
        }
    }

    func load(lat: Double, lon: Double) async {
        state = .loading
        do {
            let dto = try await weather.fetch(lat: lat, lon: lon, forecastDays: 7)
            let dailies: [DailyRowViewData] = zip(dto.daily.time.indices, dto.daily.time).map { (i, date) in
                DailyRowViewData(
                    date: date,
                    min: dto.daily.temperature2mMin[i],
                    max: dto.daily.temperature2mMax[i],
                    weatherCode: Int(dto.daily.weatherCode[i])
                )
            }

            // Transformación hourly completa (de todos los días)
            let hourly: [HourlyRowViewData] = dto.hourly.time.indices.map { i in
                HourlyRowViewData(
                    date: dto.hourly.time[i],
                    temperature: dto.hourly.temperature2m[i],
                    apparent: dto.hourly.apparentTemperature[i],
                    precipitationProb: dto.hourly.precipitationProbability[i],
                    cloudCover: dto.hourly.cloudCover[i]
                )
            }

            latestHourly = hourly
            state = .loaded(dailies, hourly: hourly)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func hourlyFor(day: Date) -> [HourlyRowViewData] {
        let cal = Calendar(identifier: .gregorian)
        return latestHourly.filter { cal.isDate($0.date, inSameDayAs: day) }
    }
}
