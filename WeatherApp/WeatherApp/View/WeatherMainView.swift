//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import SwiftUI
import Combine

struct WeatherMainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        ZStack {
            // Background
            Color(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20.0) {
                // Top View
                TopView(performAction: actionPerformed)

                // ContentView Either one of these will be shown at once
                // - Loading for waiting for location or api call
                // - Error View to show any error to user
                // - WeatherDataView to show weather data
                switch viewModel.viewstate {
                case .loading, .none:
                    LoadingView()
                case .loaded:
                    WeatherDataView(viewModel: WeatherViewModel(dataModel: viewModel.weatherDataModel, serviceManager: DataServiceManager()))
                case .error(let errorTitle):
                    ErrorView(errorTitle: errorTitle)
                }
                Spacer()
            }
        }
        .onAppear() {
            viewModel.getCurrentLocation()
        }
    }
    
    // Top view actions
    private func actionPerformed( action: TopViewActions) {
            switch action {
            case .requestLocation:
                viewModel.getCurrentLocation()
            case .searchLocation(let searchText):
                viewModel.getWeatherDataUsingSearchText(searchText)
            }
        }
    
}

#Preview {
    WeatherMainView(viewModel: MainViewModel(serviceManager: MockData(jsonString: "Some Data")))
}

class MockData: DataProvider {
    
    let testData: Data
    init(jsonString: String) {
        testData = jsonString.data(using: .utf8) ?? Data()
    }
    
    func fetchDataFrom(url: URL) -> AnyPublisher<Data, any Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}
