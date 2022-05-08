//
//  UILabel.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import UIKit.UILabel

extension UILabel {
    
    func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
}
