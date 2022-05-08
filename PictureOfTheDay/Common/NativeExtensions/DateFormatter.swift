//
//  DateFormatter.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 25/04/22.
//

import Foundation

extension DateFormatter {
    
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
    
    static func DDMMMYYYY() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    
    static func YYYYMMDD() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
