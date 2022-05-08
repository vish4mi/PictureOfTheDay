//
//  FailureResponse.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 17/04/22.
//

import Foundation

public enum FailResponse<U>: LocalizedError {
    case error(NetworkError)
    case model(U)
    case redirect(String?)
    case parse
    case noInternet
    case timeout
    case authorization
    case unknown
    case empty
    
    public var errorDescription: String {
        switch self {
        case .error(let error): return error.errorMessage ?? "Unknown error"
        case .model: return ""
        case .redirect(let value): return "Redirected to \(value ?? "")"
        case .parse: return "Can not parse"
        case .noInternet: return "No internet"
        case .timeout: return "Timeout"
        case .authorization: return "authorization"
        case .unknown: return "Unknown error"
        case .empty: return "Empty response"
        }
    }
    
    public var code: Int {
        switch self {
        case .error(let error):
            return error.statusCode ?? StatusCodeType.unknown
        default:
            return StatusCodeType.unknown
        }
    }
}

public enum StatusCodeType {
    public static let badRequest = 400
    public static let unknown = -1
}
