//
//  StorageManager.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

final class LocalStorage: LocalStorageProtocol {
    
    static let shared = LocalStorage()
    
    private let userDefaults: LocalStorageItemProtocol
    
    private init() {
        self.userDefaults = UserDefaults.standard
    }
    
    public func set(value: NetworkCacheModel, for key: LocalStorageKey) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        
        storage(with: key).set(data: data, for: key)
    }
    
    public func get(for key: LocalStorageKey) -> CacheModelProtocol? {
        guard let data = data(for: key) else { return nil }
        
        if let value = try? JSONDecoder().decode(NetworkCacheModel.self, from: data) {
            return value
        }
        return nil
    }
    
    public func removeValue(for key: LocalStorageKey) {
        storage(with: key).removeValue(for: key)
    }
    
    public func clearAll() {
        storage(with: .userDefaultKey).clearAll()
    }
    
    private func data(for key: LocalStorageKey) -> Data? {
        storage(with: key).get(dataFor: key)
    }
    
    private func storage(with key: LocalStorageKey) -> LocalStorageItemProtocol {
        switch key.storageType {
        case .userDefaults:
            return userDefaults
        default:
            return userDefaults
        }
    }
}

