//
//  ImageLoaderRequest.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import Foundation

public class ImageLoaderRequest: BaseRequest, ParametersConvertible {
    
    private let urlString: String
    
    public init(urlString: String) {
        self.urlString = urlString
    }
}

extension ImageLoaderRequest: RequestProtocol {
    public var baseURL: String { Environment.current.customURL }
    public var path: String { "\(urlString)" }
    public var method: HTTPMethod { .get }
    public var task: NetworkTask { .plain }
    public var requiresTokenInBody: Bool { false }
    public var cachePolicy: NSURLRequest.CachePolicy { .returnCacheDataElseLoad }
    public var localCachePolicy: NetworkCachePolicy { .loadFromCacheThenNetwork }
}
