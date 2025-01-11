//
//  TravelTalkTableViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {

    static let identifier = "TravelTalkTableViewCell"
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastChatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        lastChatLabel.font = .systemFont(ofSize: 13)
        lastChatLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        
        DispatchQueue.main.async {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        }
    }
    
    func configData(row: ChatRoom ) {
        print(#function
        )
        let img = row.chatroomImage[0]
        profileImage.image = UIImage(named: img)
        nameLabel.text = row.chatroomName
        
        let lastChat = row.chatList.last
        lastChatLabel.text = lastChat?.message ?? ""
        let chatDate = lastChat?.date ?? "0000-00-00 00:00"
        if let chatDate = DateFormatter.longDate.date(from: chatDate) {
            let formattedDateStr = DateFormatter.shortDate.string(from: chatDate)
            dateLabel.text = formattedDateStr
        }
        
    }
    
}
