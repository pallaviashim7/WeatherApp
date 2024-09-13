//
//  DataServiceManager.swift
//  MyWeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import Foundation
import Combine

// For dependency Injection
protocol DataProvider {
    func fetchDataFrom(url: URL) -> AnyPublisher<Data, Error>
}

// Generic class to handle any kind of data requests.
// We have two so far - to get geocode and to get the weather data

class DataServiceManager: DataProvider {
    
    func fetchDataFrom(url: URL) -> AnyPublisher<Data, Error> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap (handleOutput)
            .eraseToAnyPublisher()
        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }

}

