//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class NameMeditationVC: UIViewController {
    
    var selectedVerseKey: String = "시편 23:1-3" // 선택된 성경 구절 키
        var selectedVerseIndex: Int = 0 // 선택된 성경 구절 인덱스
    
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
        setUpBibleVersePopupMenu()
    }
    
    @IBAction func meditateButton(_ sender: Any) {
        if let userName = nameTextField.text {
            BibleVerseModel.shared.userName = userName
            if let verse = BibleVerseModel.shared.getBibleVerse(selectedVerseIndex, "\(bibleVerseButton.titleLabel?.text ?? "")") {
                bibleVerseLabel.setTextWithFadeAnimation(verse, duration: 1.0)
            }
        }
    }
    
    func setUpBibleVersePopupMenu() {
          let psalmAction = UIAction(title: "시편 23:1-3", state: selectedVerseKey == "시편 23:1-3" ? .on : .off) { action in
              self.selectedVerseKey = "시편 23:1-3"
              self.selectedVerseIndex = 0
              self.updateBibleVerseButtonTitle()
              self.setUpBibleVersePopupMenu() // 메뉴를 다시 설정하여 체크 표시 업데이트
          }
          
          let isaiahAction = UIAction(title: "이사야 40:31", state: selectedVerseKey == "이사야 40:31" ? .on : .off) { action in
              self.selectedVerseKey = "이사야 40:31"
              self.selectedVerseIndex = 1
              self.updateBibleVerseButtonTitle()
              self.setUpBibleVersePopupMenu() // 메뉴를 다시 설정하여 체크 표시 업데이트
          }
          
          let menu = UIMenu(title: "성경 구절 선택", options: .displayInline, children: [psalmAction, isaiahAction])
          bibleVerseButton.menu = menu
          bibleVerseButton.showsMenuAsPrimaryAction = true
      }
    
    func updateBibleVerseButtonTitle() {
        let customFont = UIFont(name: "BMYEONSUNG-OTF", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.white
        ]
        let attributedTitle = NSAttributedString(string: selectedVerseKey, attributes: attributes)
        bibleVerseButton.setAttributedTitle(attributedTitle, for: .normal)
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
}
