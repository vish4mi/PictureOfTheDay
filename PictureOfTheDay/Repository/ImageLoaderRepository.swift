//
//  ImageLoaderRepository.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import Foundation

protocol ImageLoaderRepositoryProtocol {
    func fetchImage(
        for url: String,
        completion: @escaping ((Data) -> ()),
        failure: @escaping ((NetworkError) -> ())
    )
}

class ImageLoaderRepository: ImageLoaderRepositoryProtocol {
    
    private let imageLoaderService: ImageLoaderServiceProtocol
    
    init() {
        imageLoaderService = ImageLoaderService()
    }
    
    func fetchImage(
        for url: String,
        completion: @escaping ((Data) -> ()),
        failure: @escaping ((NetworkError) -> ())
    ) {
        imageLoaderService.fetchImage(for: url) { imageData in
            completion(imageData)
        } failure: { error in
            failure(error)
        }
    }
}
