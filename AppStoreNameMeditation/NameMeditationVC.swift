//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class NameMeditationVC: UIViewController {
    
    let meditationIndicator = UIImageView()
    var isAnimating = false // 애니메이션 진행 상태를 추적하는 변수
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    @IBOutlet weak var bibleVerseVStackView: UIStackView!
    @IBOutlet weak var bibleVerseLabel: UILabel!
    @IBOutlet weak var bibleVerseChapterLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var meditateButton: UIButton!
    @IBOutlet weak var bibleVerseChoiceButton: UIButton!
    @IBOutlet weak var fontChoiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.borderWidth = 1.2
        nameTextField.layer.cornerRadius = 12
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseContainerView.layer.cornerRadius = 12
        setUpMeditationIndicator()
        let fontFamilies = UIFont.familyNames
        for family in fontFamilies {
            print("Font family: \(family)")
            let fontNames = UIFont.fontNames(forFamilyName: family)
            for fontName in fontNames {
                print("Font name: \(fontName)")
            }
        }
        if UserDefaults.standard.string(forKey: "selectedVerseKey") == nil {
            UserDefaults.standard.set("시편 23:1-3", forKey: "selectedVerseKey")
        }
        if UserDefaults.standard.string(forKey: "fontName") == nil {
            UserDefaults.standard.set("BMYEONSUNG-OTF", forKey: "fontName")
        }
        if UserDefaults.standard.string(forKey: "displayFontName") == nil {
            UserDefaults.standard.set("배달의민족 연성체", forKey: "displayFontName")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBibleVerseChoiceButtonTitle()
        updateFont()
        //        if let userName = UserDefaults.standard.string(forKey: "userName") {
        //            nameTextField.text = userName
        //        }
        //        if nameTextField.text?.isEmpty == true {
        //            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
        //            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
        //            let dictionary = Model.shared.originalBibleVerseDictionary
        //            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
        //                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
        //                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
        //            }
        //        } else {
        //            if let userName = nameTextField.text {
        //                Model.shared.userName = userName
        //                let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
        //                let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
        //                if let verseTuple = Model.shared.getNameBibleVerse(selectedVerseIndex, selectedVerseKey) {
        //                    bibleVerseLabel.setTextWithFadeAnimation(verseTuple.value, duration: 1.0)
        //                    bibleVerseChapterLabel.setTextWithFadeAnimation(verseTuple.key, duration: 1.0)
        //                }
        //            }
        //        }
        if bibleVerseChapterLabel.text != UserDefaults.standard.string(forKey: "selectedVerseKey") {
            meditationIndicatorAnimation()
        } else {
            stopMeditationIndicatorAnimation()
        }
    }
    
    @IBAction func meditateButton(_ sender: Any) {
        stopMeditationIndicatorAnimation()
        if nameTextField.text?.isEmpty == true {
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            let dictionary = Model.shared.originalBibleVerseDictionary
            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 24)
                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 16)
                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
            }
        } else {
            let userName = nameTextField.text!
            Model.shared.userName = userName
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            if let verseTuple = Model.shared.getNameBibleVerse(selectedVerseIndex, selectedVerseKey) {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 24)
                bibleVerseLabel.setTextWithFadeAnimation(verseTuple.value, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 16)
                bibleVerseChapterLabel.setTextWithFadeAnimation(verseTuple.key, duration: 1.0)
            }
        }
    }
    
    @IBAction func nameTextField(_ sender: Any) {
        meditationIndicatorAnimation()
        if let userName = nameTextField.text {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    
    @IBAction func bibleVerseChoiceButton(_ sender: Any) {
        let bibleVerseChoiceVC = BibleVerseChoiceVC()
        bibleVerseChoiceVC.modalPresentationStyle = .fullScreen
        bibleVerseChoiceVC.delegate = self
        present(bibleVerseChoiceVC, animated: true, completion: nil)
    }
    
    @IBAction func fontChoiceButton(_ sender: Any) {
        let fontVC = FontVC()
        fontVC.modalPresentationStyle = .fullScreen
        fontVC.delegate = self
        present(fontVC, animated: true, completion: nil)
    }
    
    func setUpMeditationIndicator() {
        meditationIndicator.translatesAutoresizingMaskIntoConstraints = false
        meditationIndicator.image = UIImage(systemName: "arrowtriangle.down.fill")
        meditationIndicator.tintColor = .black
        meditationIndicator.isHidden = true
        view.addSubview(meditationIndicator)
        NSLayoutConstraint.activate([
            meditationIndicator.widthAnchor.constraint(equalToConstant: 20),
            meditationIndicator.heightAnchor.constraint(equalToConstant: 17),
            meditationIndicator.centerXAnchor.constraint(equalTo: meditateButton.centerXAnchor),
            meditationIndicator.bottomAnchor.constraint(equalTo: meditateButton.topAnchor, constant: -3)
        ])
    }
    
    func meditationIndicatorAnimation(repeatCount: Int = 10000) {
        guard !isAnimating else { return } // 애니메이션이 이미 진행 중이면 함수 종료
        isAnimating = true
        meditationIndicator.isHidden = false
        DispatchQueue.global().async {
            for _ in 0..<repeatCount {
                if !self.isAnimating { break }
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.6, animations: {
                        self.meditationIndicator.transform = CGAffineTransform(translationX: 0, y: -5)
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.6, animations: {
                            self.meditationIndicator.transform = .identity
                        })
                    })
                }
                print("Animation")
                usleep(1000000) // 1초 지연 (애니메이션 시간 포함)
            }
            DispatchQueue.main.async {
                self.isAnimating = false
            }
        }
    }
    
    func stopMeditationIndicatorAnimation() {
        isAnimating = false
        meditationIndicator.layer.removeAllAnimations()
        meditationIndicator.isHidden = true
    }
    
    func updateBibleVerseChoiceButtonTitle() {
        let customFontName = UserDefaults.standard.string(forKey: "fontName")!
        let customFont = UIFont(name: customFontName, size: 17)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.white
        ]
        bibleVerseChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "selectedVerseKey")!, attributes: attributes), for: .normal)
    }
    
    func updateFont() {
        let customFontName = UserDefaults.standard.string(forKey: "fontName")!
        let customFont = UIFont(name: customFontName, size: 17)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.white
        ]
        meditateButton.titleLabel?.font = customFont
        nameTextField.font = customFont
        bibleVerseLabel.font = UIFont(name: customFontName, size: 23)
        bibleVerseChapterLabel.font = UIFont(name: customFontName, size: 16)
        meditateButton.setAttributedTitle(NSAttributedString(string: "묵상하기", attributes: attributes), for: .normal)
        bibleVerseChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "selectedVerseKey")!, attributes: attributes), for: .normal)
        let attributesForFontChoiceButton: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.black
        ]
        fontChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "displayFontName")!, attributes: attributesForFontChoiceButton), for: .normal)
    }
}

extension NameMeditationVC: BibleVerseVCDelegate {
    func didSelectBibleVerse(key: String, index: Int) {
        UserDefaults.standard.set(key, forKey: "selectedVerseKey")
        UserDefaults.standard.set(index, forKey: "selectedVerseIndex")
        updateBibleVerseChoiceButtonTitle()
        meditationIndicatorAnimation(repeatCount: 10000) // 성경 구절 변경 시 애니메이션 시작
    }
}

extension NameMeditationVC: FontVCDelegate {
    func didSelectFont(name: String, displayName: String) {
        UserDefaults.standard.set(name, forKey: "fontName")
        UserDefaults.standard.set(displayName, forKey: "displayFontName")
        updateFont()
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
