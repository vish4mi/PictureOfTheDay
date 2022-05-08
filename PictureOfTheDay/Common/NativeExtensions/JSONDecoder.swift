//
//  JSONDecoder.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 15/04/22.
//

import Foundation

extension JSONDecoder {
    
    func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
        keyDecodingStrategy = KeyDecodingStrategy.convertFromSnakeCase
        dateDecodingStrategy = DateDecodingStrategy.iso8601
        
        do {
            let parsedObject = try decode(type, from: data)
            return parsedObject
        } catch let error {
            print(error)
            return nil
        }
    }
}
