//
//  LocalStorageKeys.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

public struct LocalStorageKey: Equatable {
    public let name: String
    public let storageType: LocalStorageType
    
    public init(name: String, storageType: LocalStorageType = .userDefaults) {
        self.name = name
        self.storageType = storageType
    }
}

public extension LocalStorageKey {
    static var homeData: LocalStorageKey { .init(name: "home_data") }
    static var userDefaultKey: LocalStorageKey { .init(name: "", storageType: .userDefaults) }
}
