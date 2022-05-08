//
//  PRRepository.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 22/04/22.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchPictureOfTheDay(
        completion: @escaping (PODModel) -> (),
        failure: @escaping ((NetworkError) -> ())
    )
}

class HomeRepository: HomeRepositoryProtocol {
    
    let homeService: HomeServiceProtocol
    
    init() {
        homeService = HomeService()
    }
    
    func fetchPictureOfTheDay(
        completion: @escaping ((PODModel) -> ()),
        failure: @escaping ((NetworkError) -> ())
    ) {
        homeService.fetchPictureOfTheDay() { podModel in
            completion(podModel)
        } failure: { error in
            failure(error)
        }
    }
}
