//
//  UserTableViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    static let identifier = "UserTableViewCell"
    @IBOutlet var userMessageLabel: UILabel!
    @IBOutlet var userTimeLabel: UILabel!
    
    @IBOutlet var messageView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userMessageLabel.font = UIFont.systemFont(ofSize: 13)
        userMessageLabel.numberOfLines = 0
        userTimeLabel.textColor = .systemGray
        userTimeLabel.font = UIFont.systemFont(ofSize: 12)
        
        messageView.layer.cornerRadius = 5
        messageView.layer.borderColor = UIColor.black.cgColor
    
        messageView.layer.borderWidth = 1

    }

    func configDate(row: Chat) {
        
        userMessageLabel.text = row.message
        
        let originDate = row.date
        if let time = DateFormatter.longDate.date(from: originDate) {
            let formattedDate = DateFormatter.chatRoomDate.string(from: time)
            userTimeLabel.text = formattedDate
        }
        else {
            userTimeLabel.text = "00:00 오전"
        }
    }
    
}
