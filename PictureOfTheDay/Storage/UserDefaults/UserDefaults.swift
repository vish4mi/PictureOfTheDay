//
//  UserDefaults.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

extension UserDefaults: LocalStorageItemProtocol {
    public func get(dataFor key: LocalStorageKey) -> Data? {
        data(forKey: key.name)
    }
    
    public func set(data value: Data, for key: LocalStorageKey) {
        set(value, forKey: key.name)
        synchronize()
    }
    
    public func removeValue(for key: LocalStorageKey) {
        removeObject(forKey: key.name)
        synchronize()
    }
    
    public func clearAll() {
        let domain = Bundle.main.bundleIdentifier ?? ""
        removePersistentDomain(forName: domain)
    }
}
