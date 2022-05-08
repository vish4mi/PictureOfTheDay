//
//  UITableViewCell.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func createCell<T: UITableViewCell>(tableView: UITableView, indexPath: IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    class func createCellWithId(tableView: UITableView, indexPath: IndexPath, identifier: String) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
