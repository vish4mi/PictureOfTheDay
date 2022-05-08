//
//  PRListViewController.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 23/04/22.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: ImageLoader! {
        didSet {
            posterView.layer.cornerRadius = 6.0
            posterView.layer.borderWidth = 1.0
            posterView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var homeViewModel: HomeViewModelProtocol?

    private enum Constants {
        static let errorMessage = "There is no data available currently."
    }
    
    override func viewDidLoad() {
        homeViewModel = HomeViewModel()
        bindToViewModel()
        homeViewModel?.getPictureOfTheDay()
    }
    
    private func bindToViewModel() {
        homeViewModel?.shouldShowActivityIndicator = { shouldShow in
            DispatchQueue.main.async { [self] in
                if shouldShow {
                    containerView.animateAllSubviews()
                } else {
                    containerView.stopAnimatingAllSubviews()
                }
            }
        }
        
        homeViewModel?.loadPictureOfTheDay = { [weak self] in
            DispatchQueue.main.async {
                self?.titleLabel.text = self?.homeViewModel?.getTitle()
                self?.descriptionLabel.text = self?.homeViewModel?.getDescription()
                if let posterURL = self?.homeViewModel?.getPosterURL() {
                    self?.posterView.loadImage(from: posterURL, placeholder: UIImage(named: ""))
                }
            }
        }
    }
}

