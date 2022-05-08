//
//  Environment.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 10/04/22.
//

import Foundation

struct Constants {
    static let stagingBuildPrefix = "2"
}

public enum Environment {
    case development
    case production
    
    public static var current: Environment {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        else {
            return Environment.production
        }
        
        let arrayValues = versionNumber.components(separatedBy: ".")
        if arrayValues.count > 2, arrayValues[2] == Constants.stagingBuildPrefix {
            return .development
        } else {
            return .production
        }
    }
    
    public var podRequestURL: String {
        switch self {
        case .development: return "https://api.nasa.gov"
        case .production: return "https://api.nasa.gov"
        }
    }
    
    public var customURL: String {
        switch self {
        case .development: return ""
        case .production: return ""
        }
    }
}
