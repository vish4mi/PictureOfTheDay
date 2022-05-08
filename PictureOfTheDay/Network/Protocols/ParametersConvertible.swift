//
//  ParametersConvertible.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 10/04/22.
//

import Foundation

public protocol ParametersConvertible {
    var parameters: [String: Any] { get }
}

extension ParametersConvertible where Self: Encodable {
    public var parameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dict = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
        else {
            return [:]
        }
        return dict
    }
}
