//
//  StorageProtocols.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

public protocol LocalStorageProtocol {
    func set(value: NetworkCacheModel, for key: LocalStorageKey)
    func get(for key: LocalStorageKey) -> CacheModelProtocol?
    func removeValue(for key: LocalStorageKey)
    func clearAll()
}

public protocol LocalStorageItemProtocol {
    func get(dataFor key: LocalStorageKey) -> Data?
    func set(data value: Data, for key: LocalStorageKey)
    func removeValue(for key: LocalStorageKey)
    func clearAll()
}

public protocol CacheRepositoryProtocol {
    func getCache(for key: String) -> Data?
    func setCache(for key: String, data: Data)
    func clearAll()
}

public protocol CacheModelProtocol: Codable {
    var createdOn: Date { get }
    var key: String { get }
    var payLoad: Data { get }
}
