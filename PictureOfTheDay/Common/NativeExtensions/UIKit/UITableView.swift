//
//  UITableView.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 24/04/22.
//

import UIKit.UITableView

extension UITableView {
    
    func registerClass(for cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}
