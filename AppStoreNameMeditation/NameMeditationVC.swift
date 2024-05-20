//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class NameMeditationVC: UIViewController {
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    @IBOutlet weak var bibleVerseShareButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.borderWidth = 1.2
        bibleVerseContainerView.layer.cornerRadius = 12
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseShareButton.layer.cornerRadius = 12
    }
}
