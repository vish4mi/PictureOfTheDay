//
//  PRRequest.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 16/04/22.
//

import Foundation

public class PODRequest: BaseRequest, ParametersConvertible {

    private let apiKey: String = "ZlnO2OLp92ubTb2LpsaDuP5dOTZOuOEEN7EzDrhH"
    
    override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case date
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        if !apiKey.isEmpty {
            try container.encode(apiKey, forKey: .apiKey)
        }
    }
}

extension PODRequest: RequestProtocol {
    public var baseURL: String { Environment.current.podRequestURL }
    public var path: String { "/planetary/apod" }
    public var method: HTTPMethod { .get }
    public var task: NetworkTask { .parameters(self) }
    public var requiresTokenInBody: Bool { false }
    public var cachePolicy: NSURLRequest.CachePolicy { .returnCacheDataElseLoad }
    public var localCachePolicy: NetworkCachePolicy {.loadFromCacheThenNetwork }
}

