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
        ["시편 23:1-3": "여호와는 name의 목자시니 name이 부족함이 없으리로다 그가 name을 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다 name의 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다"],

        ["민수기 6:24-26": "여호와는 name에게 복을 주시고 name을 지키시기를 원하며 여호와는 그의 얼굴을 name에게 비추사 은혜 베푸시기를 원하며 여호와는 그 얼굴을 name에게로 향하여 드사 평강 주시기를 원하노라"
        ],
        ["신명기 31:6": "name은 강하고 담대하라 두려워하지 말라 그들 앞에서 떨지 말라 이는 네 하나님 여호와 그가 name과 함께 행하시며 결코 name을 떠나지 아니하시며 버리지 아니하실 것임이니라"
        ],
        ["예레미야 29:11": "여호와의 말씀이니라 name을 향한 나의 생각을 내가 아나니 평안이요 재앙이 아니니라 name에게 미래와 희망을 주는 것이니라"],
        ["예레미야 33:3": "name은 내게 부르짖으라 내가 name에게 응답하겠고 name이 알지 못하는 크고 은밀한 일을 name에게 보이리라"],
        ["욥기 23:10": "name이 가는 길을 그가 아시나니 그가 name을 단련하신 후에는 name이 정금 같이 나오리라"],
        ["시편 46:1": "하나님은 name의 피난처시요 힘이시니 환난 중에 만날 큰 도움이시라"],
        ["잠언 3:5-6": "name은 마음을 다하여 여호와를 신뢰하고 name의 명철을 의지하지 말라 name은 범사에 그를 인정하라 그리하면 name의 길을 지도하시리라"],
        ["잠언 4:23": "모든 지킬 만한 것 중에 더욱 name의 마음을 지키라 생명의 근원이 이에서 남이니라"],
        ["잠언 16:3": "name의 행사를 여호와께 맡기라 그리하면 name이 경영하는 것이 이루어지리라"],
        ["이사야 40:31": "오직 여호와를 앙망하는 name은 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요 달음박질하여도 곤비치 아니하겠고 걸어가도 피곤치 아니하리로다"],
        ["이사야 41:10": "두려워하지 말라 내가 name과 함께 함이니라 놀라지 말라 나는 name의 하나님이 됨이니라 내가 name을 굳세게 하리라 참으로 name을 도와 주리라 참으로 나의 의로운 오른손으로 name을 붙들리라"],
        ["말라기 4:2": "내 이름을 경외하는 name에게는 의로운 해가 떠올라서 치료하는 광선을 비추리니 name이 나가서 외양간에서 나온 송아지 같이 뛰리라"]
    ]
    
    let originalBibleVerseDictionary: [[String: String]] = [
        ["시편 23:1-3": "여호와는 나의 목자시니 내가 부족함이 없으리로다 그가 나를 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다 내 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다"],
        ["민수기 6:24-26": "여호와는 네게 복을 주시고 너를 지키시기를 원하며 여호와는 그의 얼굴을 네게 비추사 은혜 베푸시기를 원하며 여호와는 그 얼굴을 네게로 향하여 드사 평강 주시기를 원하노라"
        ],
        ["신명기 31:6": "너희는 강하고 담대하라 두려워하지 말라 그들 앞에서 떨지 말라 이는 네 하나님 여호와 그가 너와 함께 행하시며 결코 너를 떠나지 아니하시며 버리지 아니하실 것임이니라"
        ],
        ["예레미야 29:11": "여호와의 말씀이니라 너희를 향한 나의 생각을 내가 아나니 평안이요 재앙이 아니니라 너희에게 미래와 희망을 주는 것이니라"],
        ["예레미야 33:3": "너는 내게 부르짖으라 내가 네게 응답하겠고 네가 알지 못하는 크고 은밀한 일을 네게 보이리라"],
        ["욥기 23:10": "내가 가는 길을 그가 아시나니 그가 나를 단련하신 후에는 내가 정금 같이 나오리라"],
        ["시편 46:1": "하나님은 우리의 피난처시요 힘이시니 환난 중에 만날 큰 도움이시라"],
        ["잠언 3:5-6": "너는 마음을 다하여 여호와를 신뢰하고 네 명철을 의지하지 말라 너는 범사에 그를 인정하라 그리하면 네 길을 지도하시리라"],
        ["잠언 4:23": "모든 지킬 만한 것 중에 더욱 네 마음을 지키라 생명의 근원이 이에서 남이니라"],
        ["잠언 16:3": "너의 행사를 여호와께 맡기라 그리하면 네가 경영하는 것이 이루어지리라"],
        ["이사야 40:31": "오직 여호와를 앙망하는 자는 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요 달음박질하여도 곤비치 아니하겠고 걸어가도 피곤치 아니하리로다"],
        ["이사야 41:10": "두려워하지 말라 내가 너와 함께 함이니라 놀라지 말라 나는 네 하나님이 됨이니라 내가 너를 굳세게 하리라 참으로 너를 도와 주리라 참으로 나의 의로운 오른손으로 너를 붙들리라"],
        ["말라기 4:2": "내 이름을 경외하는 너희에게는 의로운 해가 떠올라서 치료하는 광선을 비추리니 너희가 나가서 외양간에서 나온 송아지 같이 뛰리라"]
    ]
    
    let font: [(fontName: String, displayName: String)] = [ ("SKYBORI", "하늘보리체"), ("MangoDdobak-R", "망고보드 또박체"), ("Cafe24Supermagic-OTF-Regular", "카페24슈퍼매직"), ("omyu_pretty", "오뮤다예쁨체"), ("TheJamsilOTF2Light", "롯데 더잠실체"), ("KimjungchulScript-Regular", "김정철 손글씨"), ("KCC-Chassam", "KCC 차쌤체"), ("Dovemayo_wild", "거친둘기마요"), ("AdultKid", "어른아이"), ("Sagaksagak", "사각사각"), ("GamtanRoad-Batang-Regular", "감탄로드 바탕체"), ("seolleimcoolot-SemiBold", "설레임체"), ("BMYEONSUNG-OTF", "배달의민족 연성체"), ("RIDIBatang", "리디 바탕체"), ("Ownglyph_eunbyul21-Rg", "온글잎 은별"), ("Ownglyph_ryuttung-Rg", "온글잎 류뚱체"), ("Ownglyph_noocar-Rg", "온글잎 누카"), ("Ownglyph_jooreeletter-Rg", "온글잎 주리손편지"), ("KyoboHandwriting2023wsa", "교보 손글씨 우선아"), ("Yeongdeok Blueroad", "영덕 블루로드체"), ("Yeongdeok Sea", "영덕 바다체"), ("SUITE-Regular", "스위트"), ("NanumSquareNeo-bRg", "나눔스퀘어 네오"), ("NanumBarunpenOTF", "나눔 바른펜"), ("NanumHimNaeRaNeunMarBoDan", "나눔 힘내라는말"), ("NanumYaGeunHaNeunGimJuIm", "나눔 김주임"), ("LINESeedSansKR-Regular", "Line Seed"), ("GangwonEduAll-OTFLight", "강원교육 모두체"), ("Pretendard-Regular", "프리텐다드"), ("BookkMyungjo-Bd", "부크크 명조")]
    
    func getNameBibleVerse(_ index: Int, _ key: String) -> (key: String, value: String)? {
        guard let template = nameInBibleVerseDictionary[index][key] else {
            return nil
        }
        let verse = template.replacingOccurrences(of: "name", with: userName)
        return (key, verse)
    }
}
