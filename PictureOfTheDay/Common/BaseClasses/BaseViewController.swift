//
//  BaseViewController.swift
//  PictureOfTheDay
//
//  Created by Vishal on 26/04/22.
//

import UIKit.UIViewController

class BaseViewController: UIViewController {
    
    var reachabilityObserver: Any?
    
    override func viewWillAppear(_ animated: Bool) {
        addObervers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeObervers()
    }
    
    func addObervers() {
        reachabilityObserver = NotificationCenter.default.addObserver(
            forName: kReachabilityChangedNotification,
            object: nil,
            queue: OperationQueue.main,
            using: {[weak self] notification in
                self?.checkNetworkConnectivity(notification: notification)
            }
        )
    }
    
    func removeObervers() {
        if let observer = reachabilityObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func checkNetworkConnectivity(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let isConnected: Bool = userInfo["isConnected"] as? Bool, !isConnected {
                showMessage(message: "You are not connected to the internet")
            }
        }
    }
    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
