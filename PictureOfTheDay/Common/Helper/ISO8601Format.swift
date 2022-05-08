//
//  ISO8601Format.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 25/04/22.
//

import Foundation

class ISO8601Format {
    let format: ISO8601DateFormatter
    
    init() {
        let format = ISO8601DateFormatter()
        format.formatOptions = [.withFullDate]
        format.timeZone = TimeZone(secondsFromGMT: 0)!
        self.format = format
    }
    
    func date(from string: String) -> Date {
        guard let date = format.date(from: string) else { fatalError() }
        return date
    }
}
