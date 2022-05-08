//
//  KeyedDecodingContainer.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 17/04/22.
//

import Foundation

extension KeyedDecodingContainer {
    enum ParsingError: Error {
        case keyNotFound
    }
    
    func decode<T: Decodable>(_ type: T.Type, forKeys keys: [K]) throws -> T {
        guard let value = keys.compactMap({ try? decode(type, forKey: $0) }).first else {
            throw ParsingError.keyNotFound
        }
        
        return value
    }
    
    func decodeIfPresent<T: Decodable>(_ type: T.Type, forKeys keys: [K]) throws -> T? {
        do {
            return try decode(type, forKeys: keys)
        } catch {
            return nil
        }
    }
}
