//
//  PRListViewModel.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 23/04/22.
//

import Foundation

protocol HomeViewModelProtocol {
    var shouldShowActivityIndicator: ((Bool) -> ())? { get set }
    var loadPictureOfTheDay: GenericCompletion? { get set }
    
    func getPictureOfTheDay()
    func getTitle() -> String
    func getDescription() -> String
    func getPosterURL() -> String
}

class HomeViewModel: HomeViewModelProtocol {

    let homeRepository: HomeRepository
    private var podModel: PODModel?
    var shouldShowActivityIndicator: ((Bool) -> ())?
    var loadPictureOfTheDay: GenericCompletion?
    
    init() {
        homeRepository = HomeRepository()
    }
    
    func getPictureOfTheDay() {
        shouldShowActivityIndicator?(true)
        homeRepository.fetchPictureOfTheDay() { [weak self] podModel in
            self?.shouldShowActivityIndicator?(false)
            self?.podModel = podModel
            self?.loadPictureOfTheDay?()
        } failure: { [weak self] error in
            self?.shouldShowActivityIndicator?(false)
            self?.loadPictureOfTheDay?()
        }

    }
    
    func getTitle() -> String {
        if let title = podModel?.title {
            return title
        }
        return ""
    }
    
    func getDescription() -> String {
        if let description = podModel?.explanation {
            return description
        }
        return ""
    }
    
    func getPosterURL() -> String {
        if let posterURL = podModel?.url {
            return posterURL
        }
        return ""
    }
}
