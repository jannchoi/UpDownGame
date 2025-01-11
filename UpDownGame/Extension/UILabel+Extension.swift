//
//  UILabel+Extension.swift
//  UpDownGame
//
//  Created by 최정안 on 1/9/25.
//

import UIKit

extension UILabel {
    func labelDesign(inputText: String, size: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = .black, alignment: NSTextAlignment = .left) {
        text = inputText
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textColor = color
        textAlignment = alignment
    }
}
