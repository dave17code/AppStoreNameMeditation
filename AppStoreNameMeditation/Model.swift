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
    var userName: String {
        get {
            return UserDefaults.standard.string(forKey: "userName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }

    let nameInBibleVerseDictionary: [[String: String]] = [
        ["창세기 12:2": "내가 name으로 큰 민족을 이루고 name에게 복을 주어 name의 이름을 창대하게 하리니 name은 복의 근원이 될지라"],
        ["창세기 28:15": "내가 name과 함께 있어 name이 어디로 가든지 name을 지키며 name을 이끌어 이 땅으로 돌아오게 할지라 내가 name에게 허락한 것을 다 이루기까지 name을 떠나지 아니하리라"],
        ["출애굽기 20:12": "name의 부모를 공경하라 그리하면 name의 하나님 여호와가 name에게 준 땅에서 name의 생명이 길리라"],
        ["민수기 6:24-26": "여호와는 name에게 복을 주시고 name을 지키시기를 원하며 여호와는 그의 얼굴을 name에게 비추사 은혜 베푸시기를 원하며 여호와는 그 얼굴을 name에게로 향하여 드사 평강 주시기를 원하노라"],
        ["신명기 31:6": "name은 강하고 담대하라 두려워하지 말라 그들 앞에서 떨지 말라 이는 네 하나님 여호와 그가 name과 함께 행하시며 결코 name을 떠나지 아니하시며 버리지 아니하실 것임이니라"],
        ["사무엘하 22:31": "하나님의 도는 완전하고 여호와의 말씀은 진실하니 그는 자기에게 피하는 name의 방패시로다"],
        ["욥기 23:10": "name이 가는 길을 그가 아시나니 그가 name을 단련하신 후에는 name이 정금 같이 나오리라"],
        ["시편 23:1-3": "여호와는 name의 목자시니 name이 부족함이 없으리로다 그가 name을 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다 name의 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다"],
        ["시편 27:1": "여호와는 name의 빛이요 name의 구원이시니 name이 누구를 두려워하리요 여호와는 name의 생명의 능력이시니 name이 누구를 무서워하리요"],
        ["시편 46:1": "하나님은 name의 피난처시요 힘이시니 환난 중에 만날 큰 도움이시라"],
        ["시편 62:5": "name의 영혼아 잠잠히 하나님만 바라라 무릇 name의 소망이 그로부터 나오는도다"],
        ["시편 91:1-2": "지존자의 은밀한 곳에 거하는 name은 전능자의 그늘 아래 거하리로다 name이 여호와를 가리켜 말하기를 그는 name의 피난처요 name의 요새요 name이 의뢰하는 하나님이라 하리니"],
        ["시편 119:105": "주의 말씀은 name의 발에 등이요 name의 길에 빛이니이다"],
        ["시편 121:7-8": "여호와께서 name을 지켜 모든 환난을 면하게 하시며 또 name의 영혼을 지키시리로다 여호와께서 name의 출입을 지금부터 영원까지 지키시리로다"],
        ["시편 138:7": "name이 환난 중에 다닐지라도 주께서 name을 살아나게 하시고 주의 손을 펴서 name의 원수들의 노를 막으시며 주의 오른손이 나를 구원하시리이다"],
        ["시편 145:18": "여호와는 자기에게 간구하는 모든 자 곧 진실하게 간구하는 name에게 가까이 하시는도다"],
        ["잠언 3:5-6": "name은 마음을 다하여 여호와를 신뢰하고 name의 명철을 의지하지 말라 name은 범사에 그를 인정하라 그리하면 name의 길을 지도하시리라"],
        ["잠언 4:23": "모든 지킬 만한 것 중에 더욱 name의 마음을 지키라 생명의 근원이 이에서 남이니라"],
        ["잠언 16:3": "name의 행사를 여호와께 맡기라 그리하면 name이 경영하는 것이 이루어지리라"],
        ["잠언 18:10": "여호와의 이름은 견고한 망대라 name은 그리로 달려가서 안전함을 얻느니라"],
        ["이사야 40:31": "오직 여호와를 앙망하는 name은 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요 달음박질하여도 곤비치 아니하겠고 걸어가도 피곤치 아니하리로다"],
        ["이사야 41:10": "두려워하지 말라 내가 name과 함께 함이니라 놀라지 말라 나는 name의 하나님이 됨이니라 내가 name을 굳세게 하리라 참으로 name을 도와 주리라 참으로 나의 의로운 오른손으로 name을 붙들리라"],
        ["예레미야 29:11": "여호와의 말씀이니라 name을 향한 나의 생각을 내가 아나니 평안이요 재앙이 아니니라 name에게 미래와 희망을 주는 것이니라"],
        ["예레미야 33:3": "name은 내게 부르짖으라 내가 name에게 응답하겠고 name이 알지 못하는 크고 은밀한 일을 name에게 보이리라"],
        ["에스겔 36:26": "새 영을 name 속에 두고 새 마음을 name에게 주되 name의 육신에서 굳은 마음을 제거하고 부드러운 마음을 줄 것이며"],
        ["다니엘 12:3": "지혜 있는 name은 궁창의 빛과 같이 빛날 것이요 많은 사람을 옳은데로 돌아오게 한 name은 별과 같이 영원토록 빛나리라"],
        ["요나 2:9": "name은 감사하는 목소리로 주께 제사를 드리며 name의 서원을 주께 갚겠나이다 구원은 여호와께 속하였나이다"],
        ["미가 6:8": "사람아 주께서 선한 것이 무엇임을 name에게 보이셨나니 여호와께서 name에게 구하시는 것은 오직 정의를 행하며 인자를 사랑하며 겸손하게 네 하나님과 함께 행하는 것이 아니냐"],
        ["나훔 1:7": "여호와는 선하시며 환난 날에 산성이시라 그는 자기에게 피하는 name을 아시느니라"],
        ["하박국 3:19": "주 여호와는 name의 힘이시라 name의 발을 사슴과 같게 하사 name으로 name의 높은 곳을 다니게 하시리로다"],
        ["스바냐 3:17": "name의 하나님 여호와가 name의 가운데 계시니 그는 구원을 베푸실 전능자이시라 그는 name으로 말미암아 기쁨을 이기지 못하시며 name을 잠잠히 사랑하시며 name으로 말미암아 즐거이 부르며 기뻐하시리라"],
        ["말라기 4:2": "내 이름을 경외하는 name에게는 의로운 해가 떠올라서 치료하는 광선을 비추리니 name이 나가서 외양간에서 나온 송아지 같이 뛰리라"],
        ["마태복음 11:28": "수고하고 무거운 짐 진 자들아 다 내게로 오라 내가 name을 쉬게 하리라"],
        ["마가복음 9:23": "예수께서 이르시되 할 수 있거든이 무슨 말이냐 믿는 name에게는 능히 하지 못할 일이 없느니라 하시니"]
    ]

    let originalBibleVerseDictionary: [[String: String]] = [
        ["창세기 12:2": "내가 너로 큰 민족을 이루고 네게 복을 주어 네 이름을 창대하게 하리니 너는 복의 근원이 될지라"],
        ["창세기 28:15": "내가 너와 함께 있어 네가 어디로 가든지 너를 지키며 너를 이끌어 이 땅으로 돌아오게 할지라 내가 네게 허락한 것을 다 이루기까지 너를 떠나지 아니하리라"],
        ["출애굽기 20:12": "네 부모를 공경하라 그리하면 네 하나님 여호와가 네게 준 땅에서 네 생명이 길리라"],
        ["민수기 6:24-26": "여호와는 네게 복을 주시고 너를 지키시기를 원하며 여호와는 그의 얼굴을 네게 비추사 은혜 베푸시기를 원하며 여호와는 그 얼굴을 네게로 향하여 드사 평강 주시기를 원하노라"],
        ["신명기 31:6": "너희는 강하고 담대하라 두려워하지 말라 그들 앞에서 떨지 말라 이는 네 하나님 여호와 그가 너와 함께 행하시며 결코 너를 떠나지 아니하시며 버리지 아니하실 것임이니라"],
        ["사무엘하 22:31": "하나님의 도는 완전하고 여호와의 말씀은 진실하니 그는 자기에게 피하는 모든 자의 방패시로다"],
        ["욥기 23:10": "내가 가는 길을 그가 아시나니 그가 나를 단련하신 후에는 내가 정금 같이 나오리라"],
        ["시편 23:1-3": "여호와는 나의 목자시니 내가 부족함이 없으리로다 그가 나를 푸른 초장에 누이시며 쉴만한 물가로 인도하시는도다 내 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다"],
        ["시편 27:1": "여호와는 나의 빛이요 나의 구원이시니 내가 누구를 두려워하리요 여호와는 내 생명의 능력이시니 내가 누구를 무서워하리요"],
        ["시편 46:1": "하나님은 우리의 피난처시요 힘이시니 환난 중에 만날 큰 도움이시라"],
        ["시편 62:5": "나의 영혼아 잠잠히 하나님만 바라라 무릇 나의 소망이 그로부터 나오는도다"],
        ["시편 91:1-2": "지존자의 은밀한 곳에 거하는 자는 전능자의 그늘 아래 거하리로다 내가 여호와를 가리켜 말하기를 그는 나의 피난처요 나의 요새요 내가 의뢰하는 하나님이라 하리니"],
        ["시편 119:105": "주의 말씀은 내 발에 등이요 내 길에 빛이니이다"],
        ["시편 121:7-8": "여호와께서 너를 지켜 모든 환난을 면하게 하시며 또 네 영혼을 지키시리로다 여호와께서 너의 출입을 지금부터 영원까지 지키시리로다"],
        ["시편 138:7": "내가 환난 중에 다닐지라도 주께서 나를 살아나게 하시고 주의 손을 펴서 내 원수들의 노를 막으시며 주의 오른손이 나를 구원하시리이다"],
        ["시편 145:18": "여호와는 자기에게 간구하는 모든 자 곧 진실하게 간구하는 모든 자에게 가까이 하시는도다"],
        ["잠언 3:5-6": "너는 마음을 다하여 여호와를 신뢰하고 네 명철을 의지하지 말라 너는 범사에 그를 인정하라 그리하면 네 길을 지도하시리라"],
        ["잠언 4:23": "모든 지킬 만한 것 중에 더욱 네 마음을 지키라 생명의 근원이 이에서 남이니라"],
        ["잠언 16:3": "너의 행사를 여호와께 맡기라 그리하면 네가 경영하는 것이 이루어지리라"],
        ["잠언 18:10": "여호와의 이름은 견고한 망대라 의인은 그리로 달려가서 안전함을 얻느니라"],
        ["이사야 40:31": "오직 여호와를 앙망하는 자는 새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요 달음박질하여도 곤비치 아니하겠고 걸어가도 피곤치 아니하리로다"],
        ["이사야 41:10": "두려워하지 말라 내가 너와 함께 함이니라 놀라지 말라 나는 네 하나님이 됨이니라 내가 너를 굳세게 하리라 참으로 너를 도와 주리라 참으로 나의 의로운 오른손으로 너를 붙들리라"],
        ["예레미야 29:11": "여호와의 말씀이니라 너희를 향한 나의 생각을 내가 아나니 평안이요 재앙이 아니니라 너희에게 미래와 희망을 주는 것이니라"],
        ["예레미야 33:3": "너는 내게 부르짖으라 내가 네게 응답하겠고 네가 알지 못하는 크고 은밀한 일을 네게 보이리라"],
        ["에스겔 36:26": "새 영을 너희 속에 두고 새 마음을 너희에게 주되 너희 육신에서 굳은 마음을 제거하고 부드러운 마음을 줄 것이며"],
        ["다니엘 12:3": "지혜 있는 자는 궁창의 빛과 같이 빛날 것이요 많은 사람을 옳은데로 돌아오게 한 자는 별과 같이 영원토록 빛나리라"],
        ["요나 2:9": "나는 감사하는 목소리로 주께 제사를 드리며 나의 서원을 주께 갚겠나이다 구원은 여호와께 속하였나이다"],
        ["미가 6:8": "사람아 주께서 선한 것이 무엇임을 네게 보이셨나니 여호와께서 네게 구하시는 것은 오직 정의를 행하며 인자를 사랑하며 겸손하게 네 하나님과 함께 행하는 것이 아니냐"],
        ["나훔 1:7": "여호와는 선하시며 환난 날에 산성이시라 그는 자기에게 피하는 자들을 아시느니라"],
        ["하박국 3:19": "주 여호와는 나의 힘이시라 나의 발을 사슴과 같게 하사 나로 나의 높은 곳을 다니게 하시리로다"],
        ["스바냐 3:17": "너의 하나님 여호와가 너의 가운데 계시니 그는 구원을 베푸실 전능자이시라 그는 너로 말미암아 기쁨을 이기지 못하시며 너를 잠잠히 사랑하시며 너로 말미암아 즐거이 부르며 기뻐하시리라"],
        ["말라기 4:2": "내 이름을 경외하는 너희에게는 의로운 해가 떠올라서 치료하는 광선을 비추리니 너희가 나가서 외양간에서 나온 송아지 같이 뛰리라"],
        ["마태복음 11:28": "수고하고 무거운 짐 진 자들아 다 내게로 오라 내가 너희를 쉬게 하리라"],
        ["마가복음 9:23": "예수께서 이르시되 할 수 있거든이 무슨 말이냐 믿는 자에게는 능히 하지 못할 일이 없느니라 하시니"],
    ]

    let font: [(fontName: String, displayName: String)] = [
        ("SKYBORI", "하늘보리체"), ("MangoDdobak-R", "망고보드 또박체"), ("Cafe24Supermagic-OTF-Regular", "카페24슈퍼매직"),
        ("omyu_pretty", "오뮤다예쁨체"), ("TheJamsilOTF2Light", "롯데 더잠실체"), ("KimjungchulScript-Regular", "김정철 손글씨"),
        ("KCC-Chassam", "KCC 차쌤체"), ("Dovemayo_wild", "거친둘기마요"), ("AdultKid", "어른아이"), ("Sagaksagak", "사각사각"),
        ("GamtanRoad-Batang-Regular", "감탄로드 바탕체"), ("seolleimcoolot-SemiBold", "설레임체"), ("BMYEONSUNG-OTF", "배달의민족 연성체"),
        ("RIDIBatang", "리디 바탕체"), ("Ownglyph_eunbyul21-Rg", "온글잎 은별"), ("Ownglyph_ryuttung-Rg", "온글잎 류뚱체"),
        ("Ownglyph_noocar-Rg", "온글잎 누카"), ("Ownglyph_jooreeletter-Rg", "온글잎 주리손편지"), ("KyoboHandwriting2023wsa", "교보 손글씨 우선아"),
        ("Yeongdeok Blueroad", "영덕 블루로드체"), ("Yeongdeok Sea", "영덕 바다체"), ("SUITE-Regular", "스위트"),
        ("NanumSquareNeo-bRg", "나눔스퀘어 네오"), ("NanumBarunpenOTF", "나눔 바른펜"), ("NanumHimNaeRaNeunMarBoDan", "나눔 힘내라는말"),
        ("NanumYaGeunHaNeunGimJuIm", "나눔 김주임"), ("LINESeedSansKR-Regular", "Line Seed"), ("GangwonEduAll-OTFLight", "강원교육 모두체"),
        ("Pretendard-Regular", "프리텐다드"), ("BookkMyungjo-Bd", "부크크 명조")
    ]

    func getNameBibleVerse(_ index: Int, _ key: String) -> (key: String, value: String)? {
        guard let template = nameInBibleVerseDictionary[index][key] else {
            return nil
        }
        let adjustedVerse = adjustVerse(template, userName: userName)
        return (key, adjustedVerse)
    }

    private func adjustVerse(_ verse: String, userName: String) -> String {
        guard let lastChar = userName.last else {
            return verse
        }
        // 한글 자음 또는 모음으로 끝나는지 확인
        let isKoreanVowel = (lastChar >= "\u{1161}" && lastChar <= "\u{1175}") || (lastChar >= "\u{314F}" && lastChar <= "\u{3163}")
        let isKoreanConsonant = (lastChar >= "\u{1100}" && lastChar <= "\u{1112}") || (lastChar >= "\u{3131}" && lastChar <= "\u{314E}")
        // 한글 자음 또는 모음으로 끝나면 조정하지 않음
        if isKoreanVowel || isKoreanConsonant {
            return verse.replacingOccurrences(of: "name", with: userName)
        }
        let hasBatchim = (lastChar.unicodeScalars.first!.value - 0xAC00) % 28 != 0
        var adjustedVerse = verse
        if hasBatchim {
            adjustedVerse = adjustedVerse
                .replacingOccurrences(of: "name의", with: "\(userName)의")
                .replacingOccurrences(of: "name은", with: "\(userName)은")
                .replacingOccurrences(of: "name이", with: "\(userName)이")
                .replacingOccurrences(of: "name을", with: "\(userName)을")
                .replacingOccurrences(of: "name과", with: "\(userName)과")
                .replacingOccurrences(of: "name으로", with: "\(userName)으로")
                .replacingOccurrences(of: "name에게", with: "\(userName)에게")
        } else {
            adjustedVerse = adjustedVerse
                .replacingOccurrences(of: "name의", with: "\(userName)의")
                .replacingOccurrences(of: "name은", with: "\(userName)는")
                .replacingOccurrences(of: "name이", with: "\(userName)가")
                .replacingOccurrences(of: "name을", with: "\(userName)를")
                .replacingOccurrences(of: "name과", with: "\(userName)와")
                .replacingOccurrences(of: "name으로", with: "\(userName)로")
                .replacingOccurrences(of: "name에게", with: "\(userName)에게")
        }
        // 예외 처리: 'name' 뒤에 조사가 없는 경우
        adjustedVerse = adjustedVerse.replacingOccurrences(of: "name", with: userName)
        return adjustedVerse
    }
}
