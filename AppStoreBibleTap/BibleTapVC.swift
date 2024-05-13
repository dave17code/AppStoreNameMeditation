//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class BibleTapVC: UIViewController {
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseContainerView.layer.cornerRadius = 12
        addSwipeGesture()
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
}
