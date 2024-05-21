//
//  Model.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/15/24.
//

import Foundation

struct BibleVerseModel {
    private init() {}
    static var shared = BibleVerseModel()
    var userName: String = ""
    
    let bibleVerseDictionary: [[String: String]] = [
        ["시편 23:1-3": "여호와는 name의 목자시니 name이 부족함이 없으리로다. 그가 name을 푸른 초장에 누이시며 쉴 만한 물가로 인도하시는도다. name의 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다."],
        ["이사야 40:31": "오직 여호와를 앙망하는 name은 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요. 달음박질하여도 곤비치 아니하겠고, 걸어가도 피곤치 아니하리로다."]
    ]
    
    func getBibleVerse(_ index: Int, _ key: String) -> (key: String, value: String)? {
        guard let template = bibleVerseDictionary[index][key] else {
            return nil
        }
        let verse = template.replacingOccurrences(of: "name", with: userName)
        return (key, verse)
    }
}
