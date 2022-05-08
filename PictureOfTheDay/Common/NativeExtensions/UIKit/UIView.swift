//
//  UIView.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import UIKit.UIView

extension UIView {
    
    private var activityIndicator: UIActivityIndicatorView {
        return UIActivityIndicatorView(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: 40, height: 40)
            )
        )
    }
    
    private var errorDescription: UILabel { UILabel() }
    
    func showActivityIndicator(size: CGFloat? = nil) {
        DispatchQueue.main.async { [self] in
            self.activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            if let customSize = size {
                self.activityIndicator.frame.size = CGSize(width: customSize, height: customSize)
            }
            addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            bringSubviewToFront(self.activityIndicator)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async { [self] in
            createErrorLabel(message: message)
        }
    }
    
    func hideErrorMessage() {
        DispatchQueue.main.async {
            self.errorDescription.removeFromSuperview()
        }
    }
    
    private func createErrorLabel(message: String) {
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let labelHeight = errorDescription.heightForLabel(text: message, font: font, width: self.frame.size.width - 32)
        errorDescription.frame.origin = CGPoint(x: 16, y: frame.size.height / 2)
        errorDescription.frame.size = CGSize(width: frame.width - 32, height: labelHeight)
        errorDescription.text = message
        errorDescription.font = font
        errorDescription.textAlignment = .center
        addSubview(errorDescription)
    }
}

extension UIView {
    private enum Constants {
        static var skeleton: String { "skeleton" }
        static var locations: String { "locations" }
    }
    
    private var startLocations: [NSNumber] { [-1.0,-0.5, 0.0] }
    private var endLocations: [NSNumber] { [1.0,1.5, 2.0] }
    
    private var gradientBackgroundColor: CGColor { UIColor(white: 0.85, alpha: 1.0).cgColor }
    private var gradientMovingColor: CGColor { UIColor(white: 0.75, alpha: 1.0).cgColor }
    
    private var movingAnimationDuration: CFTimeInterval { 0.8 }
    private var delayBetweenAnimationLoops: CFTimeInterval { 1.0 }
    
    private var gradientLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = Constants.skeleton
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor
        ]
        gradientLayer.locations = self.startLocations
        self.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
    
    func startViewAnimating() {
        let animation = CABasicAnimation(keyPath: Constants.locations)
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }
    
    func stopViewAnimating() {
        gradientLayer.removeAllAnimations()
        layer.sublayers?.forEach({ aLayer in
            if aLayer.name == Constants.skeleton {
                aLayer.removeFromSuperlayer()
            }
        })
    }
    
    func animateAllSubviews() {
        subviews.forEach({ $0.startViewAnimating() })
    }
    
    func stopAnimatingAllSubviews() {
        subviews.forEach({ $0.stopViewAnimating() })
    }
}
