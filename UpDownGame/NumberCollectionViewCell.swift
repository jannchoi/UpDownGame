//
//  NumberCollectionViewCell.swift
//  UpDownGame
//
//  Created by 최정안 on 1/9/25.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {

    static let identifier = "NumberCollectionViewCell"
    @IBOutlet var whiteCircleView: UIView!
    @IBOutlet var numLabel: UILabel!
    var myselected = false

    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .myBackground
        
    }
//    func configData(item: Int,  isselected: Bool) {
//        numLabel.text = "\(item)"
//
//        if isselected && !myselected {
//            whiteCircleView.backgroundColor = .black
//            numLabel.textColor = .white
//        }
//        else {
//            whiteCircleView.backgroundColor = .white
//            numLabel.textColor = .black
//        }
//        if isselected {
//            myselected.toggle()
//        }
//
//    }
    func configData(item: Int,  isselected: Bool) {
        numLabel.text = "\(item)"
        if isselected{
            whiteCircleView.backgroundColor = .black
            numLabel.textColor = .white
        }
        else {
            whiteCircleView.backgroundColor = .white
            numLabel.textColor = .black
        }

    }

    
    

}
