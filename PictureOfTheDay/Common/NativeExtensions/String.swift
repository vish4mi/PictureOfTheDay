//
//  String.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation

extension String {
    func sha256() -> String {
        guard let stringData = data(using: String.Encoding.utf8) else { return "" }
        
        return stringData.sha256()
    }
}
