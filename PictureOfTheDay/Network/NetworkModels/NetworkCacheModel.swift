//
//  NetworkCacheModel.swift
//  PictureOfTheDay
//
//  Created by Vishal on 29/04/22.
//

import Foundation

public struct NetworkCacheModel: CacheModelProtocol {
    public var createdOn: Date
    public var key: String
    public var payLoad: Data
}
