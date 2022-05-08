//
//  SuccessResponse.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 17/04/22.
//

import Foundation

public enum SuccessResponse<T> {
    case model(T)
    case empty
}
