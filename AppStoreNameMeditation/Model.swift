//
//  Model.swift
//  AppStoreBibleTap
//
//  Created by Dave on 5/15/24.
//

import Foundation

struct Model {
    private init() {}
    static var shared = Model()
    var userName: String = ""
    
    let nameInBibleVerseDictionary: [[String: String]] = [
        ["시편 23:1-3": "여호와는 name의 목자시니 name이 부족함이 없으리로다. 그가 name을 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다. name의 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다."],
        ["이사야 40:31": "오직 여호와를 앙망하는 name은 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요. 달음박질하여도 곤비치 아니하겠고, 걸어가도 피곤치 아니하리로다."],
        ["이사야 41:10": "두려워하지 말라, 내가 name과 함께 함이니라. 놀라지 말라, 나는 name의 하나님이 됨이니라. 내가 name을 굳세게 하리라. 참으로 name을 도와 주리라. 참으로 나의 의로운 오른손으로 name을 붙들리라."]
    ]
    
    let originalBibleVerseDictionary: [[String: String]] = [
        ["시편 23:1-3": "여호와는 나의 목자시니 내가 부족함이 없으리로다. 그가 나를 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다. 내 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다."],
        ["이사야 40:31": "오직 여호와를 앙망하는 자는 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요. 달음박질하여도 곤비치 아니하겠고, 걸어가도 피곤치 아니하리로다."],
        ["이사야 41:10": "두려워하지 말라, 내가 너와 함께 함이니라. 놀라지 말라, 나는 네 하나님이 됨이니라. 내가 너를 굳세게 하리라. 참으로 너를 도와 주리라. 참으로 나의 의로운 오른손으로 너를 붙들리라."]
    ]
    
    let font: [(fontName: String, displayName: String)] = [("BMYEONSUNG-OTF", "배달의민족 연성체"), ("MangoDdobak-R", "망고보드 또박체"), ("Cafe24Supermagic-OTF-Regular", "카페24슈퍼매직"), ("omyu_pretty", "오뮤다예쁨체"), ("TheJamsilOTF2Light", "롯데 더잠실체"), ("KimjungchulScript-Regular", "김정철 손글씨"), ("KCC-Chassam", "KCC 차쌤체"), ("Dovemayo_wild", "거친둘기마요"), ("AdultKid", "어른아이"), ("Sagaksagak", "사각사각"), ("GamtanRoad-Batang-Regular", "감탄로드 바탕체"), ("seolleimcoolot-SemiBold", "설레임체"), ("SKYBORI", "하늘보리체"), ("RIDIBatang", "리디 바탕체"), ("Ownglyph_eunbyul21-Rg", "온글잎 은별"), ("Ownglyph_ryuttung-Rg", "온글잎 류뚱체"), ("Ownglyph_noocar-Rg", "온글잎 누카"), ("Ownglyph_jooreeletter-Rg", "온글잎 주리손편지")]
    
    func getNameBibleVerse(_ index: Int, _ key: String) -> (key: String, value: String)? {
        guard let template = nameInBibleVerseDictionary[index][key] else {
            return nil
        }
        let verse = template.replacingOccurrences(of: "name", with: userName)
        return (key, verse)
    }
}
