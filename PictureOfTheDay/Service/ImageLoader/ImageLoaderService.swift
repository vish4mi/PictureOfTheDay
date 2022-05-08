//
//  ImageLoaderService.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import Foundation

protocol ImageLoaderServiceProtocol {
    func fetchImage(
        for url: String,
        completion: @escaping (Data) -> (),
        failure: @escaping (NetworkError) -> ()
    )
}

class ImageLoaderService: BaseService, ImageLoaderServiceProtocol {
    
    func fetchImage(
        for url: String,
        completion: @escaping (Data) -> (),
        failure: @escaping (NetworkError) -> ()
    ) {
        request(type: Data.self, request: ImageLoaderRequest(urlString: url), completion: completion, failure: failure)
    }
}
