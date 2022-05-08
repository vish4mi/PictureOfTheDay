//
//  NetworkError.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 17/04/22.
//

import Foundation

public struct NetworkError: Codable {
    public let statusCode: Int?
    public let errorMessage: String?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case statusCode
        case errorMessage
    }
    
    init(statusCode: Int, errorMessage: String) {
        self.statusCode = statusCode
        self.errorMessage = errorMessage
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let statusCodeValue = try? container.decode(String.self, forKey: .statusCode) {
            statusCode = Int(statusCodeValue)
        } else {
            statusCode = try container.decode(Int.self, forKey: .statusCode)
        }
        
        errorMessage = try container.decode(String.self, forKey: .errorMessage)
    }
}
