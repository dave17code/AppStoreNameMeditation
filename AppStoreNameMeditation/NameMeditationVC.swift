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
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var bibleVerseShareButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.borderWidth = 1.2
//        bibleVerseContainerView.layer.cornerRadius = 12
//        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseShareButton.layer.cornerRadius = 12
    }
    
    @IBAction func meditateButton(_ sender: Any) {
        let rectView = UIView()
        rectView.translatesAutoresizingMaskIntoConstraints = false
        rectView.layer.borderWidth = 1.6
        rectView.layer.cornerRadius = 12
        bibleVerseContainerView.addSubview(rectView)
        let stackViewHeight = bibleVerseVStackView.frame.height
        NSLayoutConstraint.activate([
            rectView.leadingAnchor.constraint(equalTo: bibleVerseContainerView.leadingAnchor),
            rectView.trailingAnchor.constraint(equalTo: bibleVerseContainerView.trailingAnchor),
            rectView.centerXAnchor.constraint(equalTo: bibleVerseContainerView.centerXAnchor),
            rectView.centerYAnchor.constraint(equalTo: bibleVerseVStackView.centerYAnchor),
            rectView.heightAnchor.constraint(equalToConstant: stackViewHeight + 100)
        ])
        rectView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            rectView.alpha = 1
        }
    }
}
