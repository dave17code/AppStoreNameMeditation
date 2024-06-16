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
    private let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bibleVerseChapter = Model.shared.originalBibleVerseDictionary.map {
            $0.keys.first ?? ""
        }
        print(bibleVerseChapter.count)
        setupHeaderView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToSelectedVerse()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .black
        let titleLabel = UILabel()
        titleLabel.text = "성경 말씀 선택"
        titleLabel.font = UIFont(name: UserDefaults.standard.string(forKey: "fontName")!, size: 19)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 45),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        print(indexPath.row)
        let selectedItem = bibleVerseChapter[indexPath.row]
        UserDefaults.standard.set(selectedItem, forKey: "selectedVerseKey")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedVerseIndex")
        delegate?.didSelectBibleVerse()
        dismiss(animated: true, completion: nil)
    }
    
    private func scrollToSelectedVerse() {
        let selectedVerseIndex = UserDefaults.standard.integer(forKey: "selectedVerseIndex")
        let indexPath = IndexPath(row: selectedVerseIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
