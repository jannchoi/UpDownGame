//
//  DateFormatter+Extension.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import Foundation

extension DateFormatter {
    static var longDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
    
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }
    
    static var chatRoomDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm a"
        return formatter
    }
}
