//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherMainView(viewModel: MainViewModel(serviceManager: DataServiceManager())) // Dependency Injection
        }
    }
}
