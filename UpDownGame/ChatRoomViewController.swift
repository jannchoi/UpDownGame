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

    @IBOutlet var chatTextView: UITextView!
    
    var chatRoomInfo: ChatRoom?
    lazy var updatedChatList = listUpdate(list: chatRoomInfo?.chatList ?? [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib(id: UserTableViewCell.identifier, tableView: chattingTableView)
        registerXib(id: OtherTableViewCell.identifier, tableView: chattingTableView)
        registerXib(id: DateTableViewCell.identifier, tableView: chattingTableView)

        chattingTableView.dataSource = self
        chattingTableView.delegate = self
        
        navigationItem.title = chatRoomInfo?.chatroomName ?? "알수없음"
        
        chatTextView.delegate = self
        chatTextView.backgroundColor = .systemGray
        chatTextView.layer.cornerRadius = 5
        chatTextView.isScrollEnabled = false
        chatTextView.text = ""
        chatTextView.font = UIFont.systemFont(ofSize: 13)
        
        
        //테이블뷰가 완전히 로드된 후 수행(비동기)
        DispatchQueue.main.async {
            self.goToBottom()
        }
        
        //테이블뷰 라인 없애기
        chattingTableView.separatorStyle = .none
        
        //키보드 동작에 대한 notification 등록
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         */
        
    }

    /*
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        
        self.view.frame.origin.y = -keyboardHeight
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
     */
    func registerXib(id: String, tableView: UITableView) {
        let xib = UINib(nibName: id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: id)
    }

    func goToBottom() {
        let lastIdx = chattingTableView.numberOfRows(inSection: 0) - 1
        if lastIdx >= 0 {
            let indexPath = IndexPath(row: lastIdx, section: 0)
            chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }

}
extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil

    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "메세지를 입력하세요."
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            view.endEditing(true)
        }
        return true
    }
    
    //textView 크기 늘리기
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach{
            constraint in
            if estimatedSize.height <= 100 {
            }
                else {
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimatedSize.height
                    
                }
            }
        }
    }
    func dateChange(date: String?) -> String{
        let originDate = date ?? "2025-01-01 00:00"
        let result: String
        if let date = DateFormatter.longDate.date(from: originDate) {
            let formattedDate = DateFormatter.shortDate.string(from: date)
            result = formattedDate
        } else {
            result = "00.00.00"
        }
        return result
    }
    func listUpdate(list: [Chat]) -> [Chat]{
        var list = list
        var idx = 0
        while true {
            idx += 1
            if dateChange(date: list[idx - 1].date) != dateChange(date: list[idx].date) {
                list.insert(list[idx], at: idx)
            }
            if idx == list.count - 1{
                break
            }
        }
        return list
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let row = chatRoomInfo?.chatList[indexPath.row] else {
//            let cell = chattingTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
//            return cell
//        }
        let row = updatedChatList[indexPath.row]
        if indexPath.row != 0 &&
            dateChange(date: row.date)
            != dateChange(date: updatedChatList[indexPath.row - 1].date) {
            let cell = chattingTableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier) as! DateTableViewCell
            cell.dateLabel.text = dateChange(date: row.date)
            return cell
        }
        
        if updatedChatList[indexPath.row].user.rawValue == "User" {
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
