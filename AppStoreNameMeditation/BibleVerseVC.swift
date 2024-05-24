//
//  BibleVerseVC.swift
//  AppStoreNameMeditationp
//
//  Created by Dave on 5/23/24.
//

import UIKit

protocol BibleVerseVCDelegate: AnyObject {
    func didSelectBibleVerse(key: String, index: Int)
}

class BibleVerseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var bibleVerseChapter: [String] = []
    weak var delegate: BibleVerseVCDelegate? // 델리게이트 프로퍼티 추가
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // BibleVerseModel 싱글톤에서 데이터를 가져와서 items 배열을 초기화합니다.
        bibleVerseChapter = BibleVerseModel.shared.originalBibleVerseDictionary.map { $0.keys.first ?? "" }
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
        titleLabel.font = UIFont(name: "BMYEONSUNG-OTF", size: 19)
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
        return BibleVerseModel.shared.originalBibleVerseDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let customFont = UIFont(name: "BMYEONSUNG-OTF", size: 17) ?? UIFont.systemFont(ofSize: 17)
        cell.textLabel?.font = customFont
        cell.textLabel?.text = bibleVerseChapter[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = bibleVerseChapter[indexPath.row]
        // 선택한 성경 구절을 유저디폴트에 저장
        UserDefaults.standard.set(selectedItem, forKey: "selectedVerseKey")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedVerseIndex")
        // 델리게이트 메서드 호출
        delegate?.didSelectBibleVerse(key: selectedItem, index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}
