//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class NameMeditationVC: UIViewController, UITextFieldDelegate {

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
        nameTextField.delegate = self
        nameTextField.layer.borderWidth = 1.2
        nameTextField.layer.cornerRadius = 12
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseContainerView.layer.cornerRadius = 12
        setUpMeditationIndicator()
        if UserDefaults.standard.string(forKey: "fontName") == nil {
            UserDefaults.standard.set("SKYBORI", forKey: "fontName")
        }
        if UserDefaults.standard.string(forKey: "displayFontName") == nil {
            UserDefaults.standard.set("하늘보리체", forKey: "displayFontName")
        }
        if UserDefaults.standard.string(forKey: "selectedVerseKey") == nil || UserDefaults.standard.integer(forKey: "bibleVerseFontSize") == 0 {
            UserDefaults.standard.set(0, forKey: "selectedVerseIndex")
            UserDefaults.standard.set("창세기 12:2", forKey: "selectedVerseKey")
            UserDefaults.standard.set(23, forKey: "bibleVerseFontSize") // 기본 폰트 사이즈 설정
            UserDefaults.standard.set(17, forKey: "bibleChapterFontSize") // 기본 폰트 사이즈 설정
            UserDefaults.standard.set(17, forKey: "buttonFontSize") // 기본 폰트 사이즈 설정
        }
        updateBibleVerse()
        // 키보드 이벤트를 감지하기 위한 옵저버 추가
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userName = UserDefaults.standard.string(forKey: "userName"), !userName.isEmpty {
            nameTextField.text = userName
        }
        updateBibleVerseChoiceButtonTitle()
        updateFont()
        if bibleVerseChapterLabel.text != UserDefaults.standard.string(forKey: "selectedVerseKey") {
            meditationIndicatorAnimation()
        } else {
            stopMeditationIndicatorAnimation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // UITextFieldDelegate 메서드 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Key Pressed")
        textField.resignFirstResponder()
        return true
    }

    @IBAction func meditateButton(_ sender: Any) {
        stopMeditationIndicatorAnimation()
        if nameTextField.text?.isEmpty == true {
            let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
            let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
            let dictionary = Model.shared.originalBibleVerseDictionary
            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleVerseFontSize")))
                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleChapterFontSize")))
                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
            }
        } else {
            let userName = nameTextField.text ?? Model.shared.userName
            if containsInvalidCharacters(userName) {
                bibleVerseLabel.setTextWithFadeAnimation("한글이 정확하게 입력되지 않았습니다 이름을 정확하게 입력해주세요", duration: 1.0)
                bibleVerseChapterLabel.setTextWithFadeAnimation("입력 오류", duration: 1.0)
            } else {
                Model.shared.userName = userName
                UserDefaults.standard.set(userName, forKey: "userName") // 유저 이름 저장
                updateBibleVerse()
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
        let fontChoiceVC = FontChoiceVC()
        fontChoiceVC.modalPresentationStyle = .fullScreen
        fontChoiceVC.delegate = self
        present(fontChoiceVC, animated: true, completion: nil)
    }

    func setUpMeditationIndicator() {
        meditationIndicator.translatesAutoresizingMaskIntoConstraints = false
        meditationIndicator.image = UIImage(systemName: "arrowtriangle.down.fill")
        meditationIndicator.tintColor = .black
        meditationIndicator.isHidden = true
        view.addSubview(meditationIndicator)
        NSLayoutConstraint.activate([
            meditationIndicator.widthAnchor.constraint(equalToConstant: 19),
            meditationIndicator.heightAnchor.constraint(equalToConstant: 16),
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
        let customFont = UIFont(name: customFontName, size: CGFloat(UserDefaults.standard.integer(forKey: "buttonFontSize")))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont ?? "",
            .foregroundColor: UIColor.white
        ]
        bibleVerseChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "selectedVerseKey")!, attributes: attributes), for: .normal)
    }

    func updateFont() {
        guard let customFontName = UserDefaults.standard.string(forKey: "fontName") else { return }
        let bibleVerseFontSize = CGFloat(UserDefaults.standard.integer(forKey: "bibleVerseFontSize"))
        let bibleChapterFontSize = CGFloat(UserDefaults.standard.integer(forKey: "bibleChapterFontSize"))
        let buttonFontSize = CGFloat(UserDefaults.standard.integer(forKey: "buttonFontSize"))
        let bibleVerseFont = UIFont(name: customFontName, size: bibleVerseFontSize)
        let bibleChapterFont = UIFont(name: customFontName, size: bibleChapterFontSize)
        let buttonFont = UIFont(name: customFontName, size: buttonFontSize)
        bibleVerseLabel.font = bibleVerseFont
        bibleVerseChapterLabel.font = bibleChapterFont
        meditateButton.titleLabel?.font = buttonFont
        nameTextField.font = buttonFont
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .font: buttonFont as Any,
            .foregroundColor: UIColor.white
        ]
        let fontChoiceButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: buttonFont as Any,
            .foregroundColor: UIColor.black
        ]
        meditateButton.setAttributedTitle(NSAttributedString(string: "묵상하기", attributes: buttonAttributes), for: .normal)
        bibleVerseChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "selectedVerseKey") ?? "", attributes: buttonAttributes), for: .normal)
        fontChoiceButton.setAttributedTitle(NSAttributedString(string: UserDefaults.standard.string(forKey: "displayFontName") ?? "", attributes: fontChoiceButtonAttributes), for: .normal)
    }

    private func containsIncompleteKoreanCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            let value = scalar.value
            // Hangul Jamo: 0x1100–0x11FF, 0x3130–0x318F, 0xA960–0xA97F, 0xD7B0–0xD7FF
            if (0x1100...0x11FF).contains(value) ||
                (0x3130...0x318F).contains(value) ||
                (0xA960...0xA97F).contains(value) ||
                (0xD7B0...0xD7FF).contains(value) {
                return true
            }
        }
        return false
    }

    private func containsInvalidCharacters(_ text: String) -> Bool {
        let pattern = "^[가-힣]+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) == nil || containsIncompleteKoreanCharacters(text)
    }
    
    private func updateBibleVerse() {
        let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
        let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
        if let userName = UserDefaults.standard.string(forKey: "userName"), !userName.isEmpty {
            Model.shared.userName = userName
            if let verseTuple = Model.shared.getNameBibleVerse(selectedVerseIndex, selectedVerseKey) {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleVerseFontSize")))
                bibleVerseLabel.setTextWithFadeAnimation(verseTuple.value, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleChapterFontSize")))
                bibleVerseChapterLabel.setTextWithFadeAnimation(verseTuple.key, duration: 1.0)
            }
        } else {
            let dictionary = Model.shared.originalBibleVerseDictionary
            if let originalVerse = dictionary[selectedVerseIndex][selectedVerseKey] {
                bibleVerseLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleVerseFontSize")))
                bibleVerseLabel.setTextWithFadeAnimation(originalVerse, duration: 1.0)
                bibleVerseChapterLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleChapterFontSize")))
                bibleVerseChapterLabel.setTextWithFadeAnimation(selectedVerseKey, duration: 1.0)
            }
        }
    }

    // 키보드가 나타날 때 호출되는 메서드
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomOfTextField = nameTextField.convert(nameTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                self.view.frame.origin.y = 0 - (bottomOfTextField - topOfKeyboard + 20)
            }
        }
    }

    // 키보드가 사라질 때 호출되는 메서드
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension NameMeditationVC: BibleVerseVCDelegate {
    func didSelectBibleVerse() {
        let selectedVerseKey = UserDefaults.standard.string(forKey: "selectedVerseKey") ?? ""
        if bibleVerseChapterLabel.text != selectedVerseKey {
            meditationIndicatorAnimation()
        }
    }
}

extension NameMeditationVC: FontChoiceVCDelegate {
    func didSelectFont() {
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
