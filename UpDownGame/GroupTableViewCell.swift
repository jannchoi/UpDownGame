//
//  GroupTableViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    static let identifier = "GroupTableViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var profileImageCollection: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        messageLabel.font = .systemFont(ofSize: 13)
        messageLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        
        for img in profileImageCollection.indices {
            DispatchQueue.main.async {
                self.profileImageCollection[img].layer.cornerRadius = self.profileImageCollection[img].frame.width / 2
            }
        }
    }
    
    func configData(row: ChatRoom) {
        
        for item in profileImageCollection.indices {
            if item <= profileImageCollection.count {
                profileImageCollection[item].image = UIImage(named: row.chatroomImage[item])
            } else {
                profileImageCollection[item].isHidden = true
            }
        }
        
        nameLabel.text = row.chatroomName
        let lastChat = row.chatList.last
        messageLabel.text = lastChat?.message ?? ""
        let chatDate = lastChat?.date ?? "0000-00-00 00:00"
        if let chatDate = DateFormatter.longDate.date(from: chatDate) {
            let formattedDateStr = DateFormatter.shortDate.string(from: chatDate)
            dateLabel.text = formattedDateStr
        }
    }
    
}
