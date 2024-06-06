//
//  BibleVerseVC.swift
//  AppStoreNameMeditationp
//
//  Created by Dave on 5/23/24.
//

import UIKit

protocol BibleVerseVCDelegate: AnyObject {
    func didSelectBibleVerse()
}

class BibleVerseChoiceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: BibleVerseVCDelegate?
    var bibleVerseChapter: [String] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bibleVerseChapter = Model.shared.originalBibleVerseDictionary.map {
            $0.keys.first ?? ""
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45))
        headerView.backgroundColor = .black
        let titleLabel = UILabel()
        titleLabel.text = "성경 말씀 선택"
        titleLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 19)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        tableView.tableHeaderView = headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.originalBibleVerseDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let label = UILabel()
        label.text = bibleVerseChapter[indexPath.row]
        label.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: CGFloat(UserDefaults.standard.integer(forKey: "bibleChapterFontSize")))
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
        if indexPath.row == selectedVerseIndex {
            let checkmarkImage = UIImage(systemName: "checkmark.seal.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
            let checkmarkImageView = UIImageView(image: checkmarkImage)
            checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(checkmarkImageView)
            NSLayoutConstraint.activate([
                checkmarkImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: -1),
                checkmarkImageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 17),
                checkmarkImageView.widthAnchor.constraint(equalToConstant: 19),
                checkmarkImageView.heightAnchor.constraint(equalToConstant: 17)
            ])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = bibleVerseChapter[indexPath.row]
        UserDefaults.standard.set(selectedItem, forKey: "selectedVerseKey")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedVerseIndex")
        delegate?.didSelectBibleVerse()
        dismiss(animated: true, completion: nil)
    }
}
