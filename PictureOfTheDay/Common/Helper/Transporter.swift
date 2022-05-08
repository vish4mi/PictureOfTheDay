//
//  Transporter.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 23/04/22.
//

import Foundation

class Transporter<T> {
    let data: T
    
    init(data: T) {
        self.data = data
    }
}
