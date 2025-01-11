//
//  TravelTalkViewController.swift
//  UpDownGame
//
//  Created by 최정안 on 1/10/25.
//

import UIKit

class TravelTalkViewController: UIViewController {

    let talkList = mockChatList
    var filteredList = mockChatList
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        let id = TravelTalkTableViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: id)
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        

        searchBar.delegate = self
    }

}
extension TravelTalkViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        view.endEditing(true)
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.showsCancelButton = false
        view.endEditing(true)
    }
    
    // 서치바 탭해서 커서 깜빡일때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        print(#function)
    }
    // 텍스트 바뀔 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        let input = searchText.lowercased()
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)

        var tempList = [ChatRoom]()
        if trimmedInput.isEmpty {
            filteredList = talkList
        } else {
            for item in talkList.indices {
                if talkList[item].chatroomName.lowercased().contains(trimmedInput){
                    tempList.append(talkList[item])
                }
            }
            filteredList = tempList
        }
        chatTableView.reloadData()
    }

}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier) as! TravelTalkTableViewCell
        let row = filteredList[indexPath.row]
        cell.configData(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "TravelTalk", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ChatRoomViewController.identifier) as! ChatRoomViewController
        //let nav = UINavigationController(rootViewController: vc)

        vc.chatRoomInfo = filteredList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        //present(nav, animated: true)
    }
    
    
}
