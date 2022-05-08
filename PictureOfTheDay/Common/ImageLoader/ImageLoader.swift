//
//  ImageLoader.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 23/04/22.
//

import Foundation
import UIKit

class ImageLoader: UIImageView {
    
    let imageLoaderRepository: ImageLoaderRepositoryProtocol
    
    required init?(coder: NSCoder) {
        self.imageLoaderRepository = ImageLoaderRepository()
        super.init(coder: coder)
    }
    
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        if !urlString.isEmpty {
            setImage(image: placeholder)
            showActivityIndicator()
            imageLoaderRepository.fetchImage(for: urlString) { [weak self] imageData in
                self?.hideActivityIndicator()
                guard let image = UIImage(data: imageData) else { return }
                self?.setImage(image: image)
            } failure: { [weak self] error in
                self?.hideActivityIndicator()
            }
        } else {
            setImage(image: placeholder)
        }
    }
    
    private func setImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
