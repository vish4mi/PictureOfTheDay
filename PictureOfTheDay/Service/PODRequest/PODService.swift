//
//  PullRequestService.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 16/04/22.
//

import Foundation

public protocol HomeServiceProtocol {
    func fetchPictureOfTheDay(
        completion: @escaping (PODModel) -> (),
        failure: @escaping (NetworkError) -> ()
    )
}

class HomeService: BaseService, HomeServiceProtocol {
    
    func fetchPictureOfTheDay(completion: @escaping (PODModel) -> (), failure: @escaping (NetworkError) -> ()) {
        request(type: PODModel.self, request: PODRequest(), completion: completion, failure: failure)
    }
}
