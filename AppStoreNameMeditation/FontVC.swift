//
//  FontVC.swift
//  AppStoreNameMeditationp
//
//  Created by Dave on 5/28/24.
//

import UIKit

protocol FontVCDelegate: AnyObject {
    func didSelectFont()
}

class FontVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: FontVCDelegate?
    var font: [(fontName: String, displayName: String)] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        font = Model.shared.font
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
        titleLabel.text = "폰트 선택"
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
        let selectedFont = Model.shared.font[indexPath.row]
        UserDefaults.standard.set(selectedFont.fontName, forKey: "fontName")
        UserDefaults.standard.set(selectedFont.displayName, forKey: "displayFontName")
        
        // 각 폰트에 대해 적절한 크기를 설정합니다.
        switch indexPath.row {
        case 0:
            UserDefaults.standard.set(23, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(17, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(17, forKey: "buttonFontSize")
        case 1:
            UserDefaults.standard.set(21, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(15, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(15, forKey: "buttonFontSize")
        // 여기에 각 폰트별로 폰트 크기를 설정하는 추가 case를 작성합니다.
        default:
            UserDefaults.standard.set(23, forKey: "bibleVerseFontSize")
            UserDefaults.standard.set(17, forKey: "bibleChapterFontSize")
            UserDefaults.standard.set(17, forKey: "buttonFontSize")
        }
        delegate?.didSelectFont()
        dismiss(animated: true, completion: nil)
    }
}
