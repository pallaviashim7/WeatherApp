//
//  ImageCacheManager.swift
//  WeatherApp
//
//  Created by Pallavi Ashim on 9/12/24.
//

import Foundation
import SwiftUI


class ImageCacheManager {
    
    static let instance = ImageCacheManager() // To.Do To Inject as dependency
    private init() { }
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
}
