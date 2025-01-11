//
//  ChatRoomViewController.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class ChatRoomViewController: UIViewController {

    static let identifier = "ChatRoomViewController"
    @IBOutlet var chattingTableView: UITableView!
    var chatRoomInfo: ChatRoom?
//    struct ChatRoom {
//        let chatroomId: Int //채팅방 고유 ID
//        let chatroomImage: [String] //채팅방에 속한 유저 이미지
//        let chatroomName: String //채팅방 이름
//        var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userxib = UINib(nibName: UserTableViewCell.identifier, bundle: nil)
        chattingTableView.register(userxib, forCellReuseIdentifier: UserTableViewCell.identifier)

        let otherxib = UINib(nibName: OtherTableViewCell.identifier, bundle: nil)
        chattingTableView.register(otherxib, forCellReuseIdentifier: OtherTableViewCell.identifier)

        chattingTableView.dataSource = self
        chattingTableView.delegate = self
        
        navigationItem.title = chatRoomInfo?.chatroomName ?? "알수없음"
        
    }
    

}
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomInfo?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = chatRoomInfo?.chatList[indexPath.row] else {
            let cell = chattingTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
            return cell
        }
        
        if chatRoomInfo?.chatList[indexPath.row].user.rawValue == "User" {
            let cell = chattingTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
            
            cell.configDate(row: row)
            return cell
        } else {
            let cell = chattingTableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.identifier) as! OtherTableViewCell
            cell.configData(row: row)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
