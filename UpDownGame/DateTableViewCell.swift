//
//  DateTableViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/13/25.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    static let identifier = "DateTableViewCell"
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .center
        dateLabel.layer.cornerRadius = 5
        dateLabel.layer.borderWidth = 1
        dateLabel.layer.borderColor = UIColor.black.cgColor
    }
    
}
