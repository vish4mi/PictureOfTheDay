//
//  Data.swift
//  PictureOfTheDay
//
//  Created by Vishal on 27/04/22.
//

import Foundation
import CommonCrypto

extension Data {
    
    func sha256() -> String {
        hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        return bytes.reduce("") { $0 + String(format:"%02x", UInt8($1)) }
    }
}
