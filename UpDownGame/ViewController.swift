//
//  ViewController.swift
//  UpDownGame
//
//  Created by 최정안 on 1/9/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var maxNumTextField: UITextField!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    let imgList = ["emotion1", "emotion2", "emotion3", "emotion4", "emotion5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.labelDesign(inputText: "UP DOWN", size: 50, weight: .bold, alignment: .center)
        subtitleLabel.labelDesign(inputText: "GAME", size: 25, alignment: .center)



        startButton.setAttributedTitle(NSAttributedString(string: "시작하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.cgColor ,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)]), for: .normal)
        startButton.backgroundColor = .black
        startButton.setTitleColor(.white, for: .normal)
        view.backgroundColor = .myBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainImage.image = UIImage(named: imgList.randomElement()!)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textFieldDesign(textField: maxNumTextField, placeholder: "최대 숫자 입력")
    }
    

    @IBAction func returnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        
        guard let input = Int(maxNumTextField.text ?? "") else {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: PlayingViewController.identifier) as! PlayingViewController
        vc.maxNum = input
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func textFieldDesign(textField: UITextField, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.cgColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: .bold)])
        
        textField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        border.borderColor = UIColor.white.cgColor
        border.borderWidth = CGFloat(1.0)
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        textField.textAlignment = .center
    }
    
}

