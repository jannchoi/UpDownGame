//
//  PlayingViewController.swift
//  UpDownGame
//
//  Created by 최정안 on 1/9/25.
//

import UIKit

class PlayingViewController: UIViewController {

    static let identifier = "PlayingViewController"
    var maxNum: Int?
    lazy var numList: [Int] = Array(1...(maxNum ?? 1))
    lazy var filteredList = numList
    var answer: Int = 0
    var selectedItem: Int?
    var tryCount = 0
    lazy var isSelectedList = Array(repeating: false, count: filteredList.count)
    
    @IBOutlet var numCollectionView: UICollectionView!
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackground
        numCollectionView.backgroundColor = .myBackground
        
        let xib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        numCollectionView.register(xib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
        
        numCollectionView.delegate = self
        numCollectionView.dataSource = self
        numCollectionView.isUserInteractionEnabled = true
        
        configOutletDesign()
       
        
        checkButton.isEnabled = false
        checkButton.isUserInteractionEnabled = false
        
        tryCount = 0
        answer = Int.random(in: 1...(maxNum ?? 1) )
        print(answer)
        configCollectionViewLayout()
    }
    func configOutletDesign() {
        
        titleLabel.labelDesign(inputText: "UP DOWN", size: 50, weight: .bold, alignment: .center)
        subtitleLabel.labelDesign(inputText: "시도 횟수: \(tryCount)", size: 25, alignment: .center)

        checkButton.setAttributedTitle(NSAttributedString(string: "결과 확인하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.cgColor ,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)]), for: .normal)
        checkButton.setAttributedTitle(NSAttributedString(string: "숫자 선택하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .disabled)
        checkButton.backgroundColor = .black
        checkButton.setTitleColor(.white, for: .normal)
        
    }
    
    func configCollectionViewLayout() {
        let sectionInset: CGFloat = 4
        let cellSpacing: CGFloat = 4
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let ColViewHeight = numCollectionView.frame.height
        let cellHeight = ColViewHeight - (sectionInset * 2) - (cellSpacing *  4)
        layout.itemSize = CGSize(width: cellHeight / 5, height: cellHeight / 5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: 0)
        numCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if filteredList.count == 1 {
            let alert = UIAlertController(title: "Game Over", message: "정답 : \(answer) \n 시도 횟수 : \(tryCount)", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Home", style: .default) {
                action in self.dismiss(animated: true)
            }
            alert.addAction(cancel)
            present(alert, animated: true)
            return
        }
        guard let selectedItem else {
            return
        }
        if answer == selectedItem {
            titleLabel.text = "Good"
            filteredList = [answer]
        } else if answer < selectedItem {
            filteredList = filteredList.filter{$0 < selectedItem}
            titleLabel.text = "Down"
        } else {
            filteredList = filteredList.filter{$0 > selectedItem}
            titleLabel.text = "Up"
        }
        tryCount += 1
        subtitleLabel.text = "시도 횟수 : \(tryCount)"
        //selectedItem = nil
        isSelectedList = Array(repeating: false, count: filteredList.count)
        checkButton.isEnabled = false
        checkButton.isUserInteractionEnabled = false
        numCollectionView.reloadData()
    }
    
}


extension PlayingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = numCollectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.identifier, for: indexPath) as! NumberCollectionViewCell

        let element: Int
        
        element = filteredList[indexPath.item]
//        var selected = false
//        if selectedItem == element {
//            selected = true
//        }
        cell.configData(item: element, isselected: isSelectedList[element - filteredList[0]])
        //cell.configData(item: element, isselected: selected)
        DispatchQueue.main.async {
            cell.whiteCircleView.layer.cornerRadius = cell.whiteCircleView.frame.width / 2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        selectedItem = indexPath.item + filteredList[0]
        
        for item in filteredList.indices {
            if item == indexPath.item {
                isSelectedList[item].toggle()
            } else {
                isSelectedList[item] = false
            }
        }
        
        if isSelectedList.contains(true) {
            checkButton.isUserInteractionEnabled = true
            checkButton.isEnabled = true
        } else {
            checkButton.isUserInteractionEnabled = false
            checkButton.isEnabled = false
        }
        collectionView.reloadData()


    }
    
    
    
    
}
