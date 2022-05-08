//
//  CacheRepository.swift
//  PictureOfTheDay
//
//  Created by Vishal on 03/05/22.
//

import Foundation

class CacheRepository: CacheRepositoryProtocol {
    
    func getCache(for key: String) -> Data? {
        if let cachedData: CacheModelProtocol = LocalStorage.shared.get(
            for: LocalStorageKey(name: key, storageType: .userDefaults)
        ) {
            return cachedData.payLoad
        }
        return nil
    }
    
    func setCache(for key: String, data: Data) {
        let cacheModel = NetworkCacheModel(
            createdOn: Date(),
            key: key,
            payLoad: data
        )
        LocalStorage.shared.set(value: cacheModel, for: LocalStorageKey(name: key, storageType: .userDefaults))
    }
    
    func clearAll() {
        
    }
    
    
}
