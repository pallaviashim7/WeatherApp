//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

enum WeatherViewState {
    case loading // Weather data is not yet available
    case loaded // Weather data available - Show content
    case error(String?) // Error view
    case none // default condition
    
    func description() -> String {
        switch self {
        case .loading:
            return "loading"
        case .loaded:
            return "loaded"
        case .error(_):
            return "error"
        case .none:
            return "none"
        }
    }
    
}

class MainViewModel: NSObject, ObservableObject {
    
    @Published var viewstate: WeatherViewState = .none
    
    var weatherDataModel: WeatherDataModel?
    var location: CLLocationCoordinate2D?
    private var geocoderModel: GeocoderModel?
    private var serviceManager: DataProvider
    private let locationManager = CLLocationManager()
    private let appID = "b1b15e88fa797225412429c1c50c122a1" // To.do - store safely
    private var cancellable = Set<AnyCancellable>()
    private var isFirstTimeLoaded = true
    
    // Persisted location from previous visit
    @AppStorage("isPreviousDataAvailable") private var isPreviousDataAvailable = false
    @AppStorage("lastVisitedLocationLatitude") private var lastVisitedLocationLatitude: Double = 0
    @AppStorage("lastVisitedLocationLongitude") private var lastVisitedLocationLongitude: Double = 0
    
    init(serviceManager: DataProvider) {
        self.serviceManager = serviceManager
        super.init()
        locationManager.delegate = self
        initializeData()
    }
    
    // Check App storage and get previous coordinates if available and set to location,
    
    func initializeData() {
        if isPreviousDataAvailable {
            location = CLLocationCoordinate2D(latitude: lastVisitedLocationLatitude, longitude: lastVisitedLocationLongitude)
            getWeatherData()
        }
    }

    
    // MARK: Public Methods
    
    // If calling on launch, get saved location
    // If saved location not available or user is looking for his current location
    // Use CLLocation to request for user permission and get current location coordinates
    
    func getCurrentLocation() {
        if isFirstTimeLoaded && isPreviousDataAvailable {
            isFirstTimeLoaded = false
            initializeData()
        } else {
            if !(locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways) {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.requestLocation()
            viewstate = .loading
        }
    }
    
    // Get weather data from user search text
    // 1. Validates user entry
    // 2. Calls geocoder api to get location coordinates from string
    // 3. On Receiving the response from geocoder api, calls the api to get weather data
    
    func getWeatherDataUsingSearchText(_ text: String) {
        if validateSearchText(text) {
            viewstate = .loading
            getLocationInfo(userEntry: text)
        } else {
            viewstate = .error("Enter valid location")
        }
    }
    
    
    // MARK: Private Methods
    
    // Search Text Validation
    
    private func validateSearchText(_ text: String) -> Bool {
        return !text.isEmpty
    }
    
    // Get coordinates
    
    // To. Do - Move to a url factory to inject as dependency , for dev/prod/mock options
    
    private func getGeocoderAPIUrl(userEntry: String) -> URL? {
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(userEntry)&limit=5&appid=\(appID)"
        return URL(string: urlString)
    }
    
    
    // API call to get location coordinates
    private func getLocationInfo(userEntry: String) {
        
        guard let url = getGeocoderAPIUrl(userEntry: userEntry) else {
            viewstate = .error(nil)
            return
        }
        
        serviceManager.fetchDataFrom(url: url)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("Get Location info failed with error : \(error)")
                    self.viewstate = .error(nil)
                }
            } receiveValue: { [weak self] data in
                self?.geocoderModel = try? JSONDecoder().decode(GeocoderModel.self, from: data)
                self?.setLocationCoordintes()
                self?.getWeatherData()
            }
            .store(in: &cancellable)
    }
    
    private func setLocationCoordintes() {
        if let lat = geocoderModel?.first?.lat, let long = geocoderModel?.first?.lon {
            location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            saveUserLocationToAppStorage()
        }

    }
    
    private func saveUserLocationToAppStorage() {
        isPreviousDataAvailable = true
        lastVisitedLocationLatitude = location?.latitude ?? 0
        lastVisitedLocationLongitude = location?.longitude ?? 0
    }
    
    
    // Weather data
    
    // API call to get weather data
    
    private func getWeatherData() {
        viewstate = .loading
        
        guard let url = getWeatherDataUrl() else {
            viewstate = .error(nil)
            return
        }
        
        serviceManager.fetchDataFrom(url: url)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("Get Weather data failed with error : \(error)")
                }
            } receiveValue: { [weak self] data in
                self?.weatherDataModel = try? JSONDecoder().decode(WeatherDataModel.self, from: data)
                self?.viewstate = .loaded
            }
            .store(in: &cancellable)
        
    }
    
    // To. Do - Move to a url factory to inject as dependency , for dev/prod/mock options

    private func getWeatherDataUrl() -> URL? {
        guard let userLocation = location else {return nil}
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(userLocation.latitude)&lon=\(userLocation.longitude)&appid=\(appID)&units=imperial"
        return URL(string: urlString)
    }
    
}


extension MainViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        getWeatherData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Failed
        locationManager.requestLocation()
        viewstate = .error("Not able to get current location. Please search for location!!")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthoization status: CLAuthorizationStatus, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        switch status {
        case .restricted, .denied:
            viewstate = .error("Not able to get current location. Please search for location!!")
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable your app's location features.
            self.location = location.coordinate
            getWeatherData()
        case .notDetermined:
            break;
        @unknown default:
            fatalError()
        }
    }
}


