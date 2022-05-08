//
//  ParameterEncoding.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 16/04/22.
//

import Foundation

public enum ParametersEncoding {
    case url
    case json
    
    enum EncodedParameters {
        case queryItems([URLQueryItem])
        case httpBody(Data)
        case unknown
    }
    
    func encode(parametersConvertible: ParametersConvertible) -> EncodedParameters {
        switch self {
        case .url: return .queryItems(encodeURL(parameters: parametersConvertible.parameters))
        case .json: return encodeJSON(parameters: parametersConvertible.parameters).map { .httpBody($0) } ?? .unknown
        }
    }
    
    private func encodeURL(parameters: [String: Any]) -> [URLQueryItem] {
        return parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
    
    private func encodeJSON(parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}
