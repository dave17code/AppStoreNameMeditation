//
//  FontVC.swift
//  AppStoreNameMeditationp
//
//  Created by Dave on 5/28/24.
//

import UIKit

protocol FontChoiceVCDelegate: AnyObject {
    func didSelectFont()
}

class FontChoiceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: FontChoiceVCDelegate?
    var font: [(fontName: String, displayName: String)] = []
    private let tableView = UITableView()
    private let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        font = Model.shared.font
        print(font.count)
        setupHeaderView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToSelectedFont()
    }

    private func setupHeaderView() {
        headerView.backgroundColor = .black
        let titleLabel = UILabel()
        titleLabel.text = "폰트 선택"
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
        return Model.shared.font.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 기존의 체크마크 이미지뷰와 라벨 제거
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        // 라벨 생성 및 설정
        let label = UILabel()
        let font = Model.shared.font[indexPath.row]
        label.font = UIFont(name: font.fontName, size: 17)
        label.text = font.displayName
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        // 현재 선택된 폰트를 유저디폴트에서 가져와서 체크마크 표시
        let selectedFont = UserDefaults.standard.string(forKey: "fontName")!
        if font.fontName == selectedFont {
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
        let selectedFont = Model.shared.font[indexPath.row]
        UserDefaults.standard.set(selectedFont.fontName, forKey: "fontName")
        UserDefaults.standard.set(selectedFont.displayName, forKey: "displayFontName")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedFontIndex")  // 선택한 폰트 인덱스를 저장합니다.
        // 각 폰트에 대해 적절한 크기를 설정합니다.
        switch indexPath.row {
        case 1, 11, 13, 14, 19, 22, 26, 29:
            UserDefaults.standard.set(20, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(14, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(14, forKey: "buttonFontSize")
        case 2, 4, 6, 10, 21, 28:
            UserDefaults.standard.set(21, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(15, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(15, forKey: "buttonFontSize")
        case 0, 7, 9, 20:
            UserDefaults.standard.set(22, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(16, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(16, forKey: "buttonFontSize")
        case 3:
            UserDefaults.standard.set(24, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(18, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(18, forKey: "buttonFontSize")
        case 15:
            UserDefaults.standard.set(25, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(19, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(19, forKey: "buttonFontSize")
        case 16, 24, 25:
            UserDefaults.standard.set(26, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(20, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(20, forKey: "buttonFontSize")
        case 17:
            UserDefaults.standard.set(27, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(21, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(21, forKey: "buttonFontSize")
        default:
            UserDefaults.standard.set(23, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(17, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(17, forKey: "buttonFontSize")
        }
        delegate?.didSelectFont()
        dismiss(animated: true, completion: nil)
    }
    
    private func scrollToSelectedFont() {
        let selectedFontIndex = UserDefaults.standard.integer(forKey: "selectedFontIndex")
        let indexPath = IndexPath(row: selectedFontIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}
