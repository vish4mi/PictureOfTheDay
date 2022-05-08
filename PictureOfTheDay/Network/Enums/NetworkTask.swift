//
//  NetworkTask.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 16/04/22.
//

import Foundation

public enum NetworkTask {
    case plain
    case parameters(ParametersConvertible)
    case upload(Data)
}
