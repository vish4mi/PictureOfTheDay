//
//  Constants.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 16/04/22.
//

import Foundation

public typealias GenericCompletion = () -> ()

public let kReachabilityChangedNotification = Notification.Name("kReachabilityChangedNotification")

public enum PRState: String {
    case open = "open"
    case closed = "closed"
    case all = "all"
}
