//
//  PRListTableViewCell.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 23/04/22.
//

import UIKit

class PRListTableViewCell: UITableViewCell {
    @IBOutlet weak var prView: UIView!
    @IBOutlet weak var avtarView: ImageLoader!
    @IBOutlet weak var prTitle: UILabel!
    @IBOutlet weak var prOwnerId: UILabel!
    @IBOutlet weak var prOpenDate: UILabel!
    @IBOutlet weak var prCloseDate: UILabel!
    
    private enum Constants {
        static let openedOn = "Opened on"
        static let closedOn = "Closed on"
        static let profilePlaceHolder = "profilePlaceholder"
    }
    
//    private func setupCell(model: PODModel) {
//        prTitle.text = model.title
//        prOwnerId.text = "\(model.user?.login ?? "")"
//        if let openDateString = model.createdAt {
//            let isoDate = ISO8601Format().date(from: openDateString)
//            let openDate = DateFormatter.DDMMMYYYY().string(from: isoDate)
//            prOpenDate.text = "\(Constants.openedOn) \(openDate)"
//        } else {
//            prOpenDate.text = ""
//        }
//
//        if let closeDateString = model.closedAt {
//            let isoDate = ISO8601Format().date(from: closeDateString)
//            let closeDate = DateFormatter.DDMMMYYYY().string(from: isoDate)
//            prCloseDate.text = "\(Constants.closedOn) \(closeDate)"
//        } else {
//            prCloseDate.text = ""
//        }
//
//        if let avtarURL = model.user?.avatarUrl {
//            avtarView.loadImage(from: avtarURL, placeholder: UIImage(named: Constants.profilePlaceHolder))
//        } else {
//            avtarView.image = UIImage(named: Constants.profilePlaceHolder)
//
//        }
//    }
    
    override func prepareForReuse() {
        prTitle.text = ""
        prOwnerId.text =  ""
        prOpenDate.text = ""
        prCloseDate.text = ""
        avtarView.loadImage(from: "", placeholder: UIImage(named: ""))
    }
}

//extension PRListTableViewCell: FillableCellProtocol {
//    
//    func fill(transporter: Transporter<Any>) {
//        if let model = transporter.data as? PRReview {
//            setupCell(model: model)
//        }
//    }
//}
