//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import Foundation
import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var imageIcon: UIImage?
    
    var dataModel: WeatherDataModel?
    var serviceManager: DataProvider?
    private var cancellable = Set<AnyCancellable>()

    private let cacheManager = ImageCacheManager.instance
    
    init(dataModel: WeatherDataModel?, serviceManager: DataProvider?) {
        self.dataModel = dataModel
        self.serviceManager = serviceManager
    }
    
    func getImage() {
        let imageKey = dataModel?.weather.first?.icon ?? ""
        if let savedImage = cacheManager.get(key: imageKey) {
            imageIcon = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
    }
    
    // MARK: - Private methods
    
    private func imageUrl() -> URL? {
        let iconID = dataModel?.weather.first?.icon ?? ""
        let urlString = "https://openweathermap.org/img/wn/\(iconID)@2x.png"
        return URL(string: urlString)
    
    }
    
    private func downloadImage() {
        guard let url = imageUrl() else {
            return
        }
        serviceManager?.fetchDataFrom(url: url)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("Image Download failed : \(error)")
                }
            } receiveValue: { [weak self] data in
                self?.imageIcon = UIImage(data: data)
                let imageKey = self?.dataModel?.weather.first?.icon ?? ""
                self?.cacheManager.add(key: imageKey, value: self?.imageIcon ?? UIImage())
    
            }
            .store(in: &cancellable)
    }
    
    
    
}
