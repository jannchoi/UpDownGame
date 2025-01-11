//
//  OtherTableViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    static let identifier = "OtherTableViewCell"

    @IBOutlet var otherProfile: UIImageView!
    @IBOutlet var otherNameLabel: UILabel!
    @IBOutlet var otherMessageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var messageView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.async {
            self.otherProfile.layer.cornerRadius = self.otherProfile.frame.width / 2
        }
        otherNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        otherMessageLabel.font = UIFont.systemFont(ofSize: 13)
        
        timeLabel.textColor = .systemGray
        timeLabel.font = UIFont.systemFont(ofSize: 12)

        messageView.layer.cornerRadius = 5
        messageView.layer.borderColor = UIColor.black.cgColor
    
        messageView.layer.borderWidth = 1
    }
    
    func configData(row: Chat) {
        
        otherProfile.image = UIImage(named: row.user.profileImage)
        otherNameLabel.text = row.user.rawValue
        otherMessageLabel.text = row.message
        
        let originDate = row.date
        if let time = DateFormatter.longDate.date(from: originDate) {
            let formattedDate = DateFormatter.chatRoomDate.string(from: time)
            timeLabel.text = formattedDate
        }
        else {
            timeLabel.text = "00:00 오전"
        }
        
    }

    
}
