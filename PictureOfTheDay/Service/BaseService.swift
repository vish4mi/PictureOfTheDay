//
//  BaseService.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 15/04/22.
//

import Foundation

class BaseService {
    
    private let networkClient = NetworkClient(cacheRepository: CacheRepository())
    
    init() {}
    
    public func request<T: Codable>(
        type: T.Type,
        request: RequestProtocol,
        completion: @escaping (T) -> (),
        failure: @escaping (NetworkError) -> ()
    ) {
        networkClient.request(
            type: type,
            request: request,
            errorType: NetworkError.self,
            completion: completion,
            failure: failure
        )
    }
}
