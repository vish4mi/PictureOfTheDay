//
//  NetworkCachePolicy.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

public enum NetworkCachePolicy {
    case loadFromCacheThenNetwork
    case loadFromCache
    case loadFromNetworkSaveCache
    case loadFromNetworkNoCache
}
