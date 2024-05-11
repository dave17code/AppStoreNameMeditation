//
//  ViewController.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bibleVerseContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bibleVerseContainerView.layer.borderWidth = 1.6
        bibleVerseContainerView.layer.cornerRadius = 12
    }
}
