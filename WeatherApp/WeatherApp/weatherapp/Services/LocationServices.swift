//
//  LocationServices.swift
//  WeatherApp
//
//  Created by Jesus Perez on 29/09/25.
//

import Foundation
import CoreLocation
import Combine

protocol LocationServicing {
    var locationUpdates: AnyPublisher<CLLocation, Never> { get }
    func requestWhenInUseAuthorization()
    func requestOneShotLocation() async throws -> CLLocation
}

final class LocationService: NSObject, LocationServicing, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let subject = PassthroughSubject<CLLocation, Never>()
    var locationUpdates: AnyPublisher<CLLocation, Never> { subject.eraseToAnyPublisher() }

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func requestOneShotLocation() async throws -> CLLocation {
        try await withCheckedThrowingContinuation { cont in
            manager.requestLocation()
            // Resolución en didUpdateLocations / didFail con una sola vez
            let resolver = LocationResolver(cont: cont)
            objc_setAssociatedObject(manager, Unmanaged.passUnretained(self).toOpaque(), resolver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        subject.send(loc)
        if let resolver = objc_getAssociatedObject(manager, Unmanaged.passUnretained(self).toOpaque()) as? LocationResolver {
            resolver.resolve(loc)
            objc_setAssociatedObject(manager, Unmanaged.passUnretained(self).toOpaque(), nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let resolver = objc_getAssociatedObject(manager, Unmanaged.passUnretained(self).toOpaque()) as? LocationResolver {
            resolver.reject(error)
            objc_setAssociatedObject(manager, Unmanaged.passUnretained(self).toOpaque(), nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private final class LocationResolver {
        private var continuation: CheckedContinuation<CLLocation, Error>?
        init(cont: CheckedContinuation<CLLocation, Error>) { self.continuation = cont }
        func resolve(_ loc: CLLocation) { continuation?.resume(returning: loc); continuation = nil }
        func reject(_ err: Error) { continuation?.resume(throwing: err); continuation = nil }
    }
}
