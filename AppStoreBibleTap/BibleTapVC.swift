//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class BibleTapVC: UIViewController {
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    @IBOutlet var bibleVerseThemeButton: [UIButton]!
    @IBOutlet weak var bibleVerseShareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bibleVerseContainerView.layer.cornerRadius = 12
        bibleVerseContainerView.layer.borderWidth = 1.6
        addSwipeGesture()
        for button in bibleVerseThemeButton {
            button.layer.cornerRadius = 12
            button.layer.borderWidth = 1.2
        }
        bibleVerseShareButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "selectedButtonIndex") == nil {
            updateButtonSelection(selectedButtonIndex: 0)
        } else {
            let selectedButtonIndex = UserDefaults.standard.integer(forKey: "selectedButtonIndex")
            updateButtonSelection(selectedButtonIndex: selectedButtonIndex)
        }
    }
    
    func addSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .left
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if let settingVC = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC {
            navigationController?.pushViewController(settingVC, animated: true)
        }
    }
    
    @IBAction func bibleVerseThemeButton(_ sender: UIButton) {
        
        if let index = bibleVerseThemeButton.firstIndex(of: sender) {
            updateButtonSelection(selectedButtonIndex: index)
            print(index)
        }
    }
    
    private func updateButtonSelection(selectedButtonIndex: Int) {
        UserDefaults.standard.set(selectedButtonIndex, forKey: "selectedButtonIndex")
        UIView.animate(withDuration: 0.2, animations: {
            for (index, button) in self.bibleVerseThemeButton.enumerated() {
                if index == selectedButtonIndex {
                    button.isSelected = true
                    button.backgroundColor = .systemBlue
                    button.layer.borderWidth = 0
                    button.setTitleColor(.white, for: .normal)
                } else {
                    button.isSelected = false
                    button.backgroundColor = .white
                    button.layer.borderWidth = 1.2
                    button.setTitleColor(.black, for: .normal)
                }
            }
        })
    }
}
