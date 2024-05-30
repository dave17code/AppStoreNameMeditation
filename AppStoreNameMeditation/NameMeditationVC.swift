//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class NameMeditationVC: UIViewController {
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    @IBOutlet weak var bibleVerseVStackView: UIStackView!
    @IBOutlet weak var bibleVerseLabel: UILabel!
    @IBOutlet weak var bibleVerseChapterLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bibleVerseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.borderWidth = 1.2
        nameTextField.layer.cornerRadius = 12
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseContainerView.layer.cornerRadius = 12
        
        // 모든 폰트 패밀리 이름을 가져옵니다.
        let fontFamilies = UIFont.familyNames
        for family in fontFamilies {
            print("Font family: \(family)")
            // 해당 폰트 패밀리에 포함된 모든 폰트 이름을 가져옵니다.
            let fontNames = UIFont.fontNames(forFamilyName: family)
            for fontName in fontNames {
                print("Font name: \(fontName)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBibleVerseButtonTitle()
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            nameTextField.text = userName
        }
        if nameTextField.text?.isEmpty == true {
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            let dictionary = BibleVerseModel.shared.originalBibleVerseDictionary
            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
            }
        } else {
            let userName = nameTextField.text!
            BibleVerseModel.shared.userName = userName
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            if let verseTuple = BibleVerseModel.shared.getNameBibleVerse(selectedVerseIndex, selectedVerseKey) {
                bibleVerseLabel.setTextWithFadeAnimation(verseTuple.value, duration: 1.0)
                bibleVerseChapterLabel.setTextWithFadeAnimation(verseTuple.key, duration: 1.0)
            }
        }
        // 유저디폴트에 폰트 값이 없으면 기본 폰트를 설정
        if UserDefaults.standard.string(forKey: "selectedFont") == nil {
            UserDefaults.standard.set("BMYEONSUNG-OTF", forKey: "selectedFont")
        }
    }
    
    @IBAction func meditateButton(_ sender: Any) {
        if nameTextField.text?.isEmpty == true {
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            let dictionary = BibleVerseModel.shared.originalBibleVerseDictionary
            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "selectedFont")!, size: 23)
                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "selectedFont")!, size: 16)
                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
            }
        } else {
            let userName = nameTextField.text!
            BibleVerseModel.shared.userName = userName
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            if let verseTuple = BibleVerseModel.shared.getNameBibleVerse(selectedVerseIndex, selectedVerseKey) {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "selectedFont")!, size: 23)
                bibleVerseLabel.setTextWithFadeAnimation(verseTuple.value, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "selectedFont")!, size: 16)
                bibleVerseChapterLabel.setTextWithFadeAnimation(verseTuple.key, duration: 1.0)
            }
        }
    }
    
    @IBAction func nameTextField(_ sender: Any) {
        if let userName = nameTextField.text {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    
    @IBAction func bibleVerseButton(_ sender: Any) {
        let bibleVerseVC = BibleVerseVC()
        bibleVerseVC.delegate = self
        bibleVerseVC.modalPresentationStyle = .formSheet
        present(bibleVerseVC, animated: true, completion: nil)
    }
    
    @IBAction func fontButton(_ sender: Any) {
        let fontVC = FontVC()
        fontVC.modalPresentationStyle = .formSheet
        present(fontVC, animated: true, completion: nil)
    }
    
    func updateBibleVerseButtonTitle() {
        let customFont = UIFont(name: "BMYEONSUNG-OTF", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.white
        ]
        let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? "시편 23:1-3"
        let attributedTitle = NSAttributedString(string: selectedVerseKey, attributes: attributes)
        bibleVerseButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}

extension NameMeditationVC: BibleVerseVCDelegate {
    func didSelectBibleVerse(key: String, index: Int) {
        UserDefaults.standard.set(key, forKey: "selectedVerseKey")
        UserDefaults.standard.set(index, forKey: "selectedVerseIndex")
        updateBibleVerseButtonTitle()
    }
}

extension UILabel {
    func setTextWithFadeAnimation(_ text: String, duration: TimeInterval) {
        self.alpha = 0.0
        self.text = text
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    func setLineSpacing(lineSpacing: CGFloat) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString: NSMutableAttributedString
        if let attributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
