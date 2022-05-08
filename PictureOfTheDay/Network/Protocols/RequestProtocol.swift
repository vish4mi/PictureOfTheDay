//
//  RequestProtocol.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 10/04/22.
//

import Foundation

public protocol RequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: NetworkTask { get }
    var parametersEncoding: ParametersEncoding { get }
    var headers: [String: String] { get }
    var requiresTokenInBody: Bool { get }
    var urlParameters: [String: Any] { get }
    var updateParameters: Bool { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var localCachePolicy: NetworkCachePolicy { get }
}

public extension RequestProtocol {
    var parametersEncoding: ParametersEncoding {
        return jsonMethods.contains(method) ? .json : .url
    }
    
    var headers: [String: String] {
        return jsonMethods.contains(method) ? ["Content-Type": "application/json"] : [:]
    }
        
    var urlParameters: [String: Any] { [:] }
    
    var requiresTokenInBody: Bool { false }
    
    var updateParameters: Bool { true }
    
    private var jsonMethods: [HTTPMethod] {
        return [.post, .put, .patch, .delete]
    }
    
    var cachePolicy: URLRequest.CachePolicy { .returnCacheDataElseLoad }
    
    var localCachePolicy: NetworkCachePolicy { .loadFromCacheThenNetwork }
}

public extension RequestProtocol {
    
    func requestSha256() -> String {
        [baseURL, path, parametersString, method.rawValue].joined(separator: ".").sha256()
    }
    
    private var parametersString: String {
        switch task {
        case .plain, .upload: return ""
        case .parameters(let parametersConvertible):
            if #available(iOS 11.0, *) {
                let string = (try? JSONSerialization.data(
                                withJSONObject: parametersConvertible.parameters,
                                options: [.sortedKeys, .prettyPrinted])
                ) ?? Data()
                
                return string.sha256()
            } else {
                let string = (try? JSONSerialization.data(withJSONObject: parametersConvertible.parameters, options: .fragmentsAllowed)) ?? Data()
                
                return string.sha256()
            }
        }
    }
}
