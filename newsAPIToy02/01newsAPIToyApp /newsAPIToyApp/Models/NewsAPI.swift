//
//  Model+API.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation

// MARK: - API요청으로 인한 응답: articles
struct APIResults: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable, Hashable{
    let id: UUID = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    var favorite: Bool = false // 북마크 여부 프로퍼티
    
    // 북마크는 제외
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, urlToImage, publishedAt, content
    }
    
    static func getDummy() -> Article {
        let article = Article(author: "김창식", title: "두둥!!! 드디어 공개 손오공의 무의식의 극의", description: "드래곤볼", url: "https://www.naver.com", urlToImage: "https://t1.daumcdn.net/cfile/tistory/99A90B4D5C5E3D640D", publishedAt: "2023-06-18T10:00:00Z", content: "드래곤볼에서 등장하는 신의 기술. \n 감정을 뒤흔드는 거대한 충동을 자제했을 때 비로소 도달이 가능한 경지로, 인지 상태를 초월해 몸이 무의식 중에 스스로 반응하면서 모든 공격에 대처할 수 있게 된다.\n 초사이어인처럼 종족에 국한된 기술이 아니므로 습득만 한다면 누구라도 사용할 수 있다. 그러나 신의 경지에 오른 이가 아니면 익힐 수 없을 정도로 습득 난이도가 높기에, 현재까지 신을 제외한 인간들 중에서 이 경지에 오른 인간은 손오공 뿐이다.\n 우이스의 언급에 의하면, 무의식의 극의를 변신이라고 의식하고 있다면 완전히 구사해낼 수 없다고 한다. 이는 오공이 무의식의 극의를 일종의 변신으로 인식하고 있었기에 상시 발동이 불가능하다는 점을 지적한 것이다. 즉 후술될 내용은 오공에게만 국한된 일종의 버프기라고 생각하는 것이 이해하기 편하다. 이 기술의 주 사용자인 천사들은 무의식의 극의를 완전히 구사하는 것이 가능해서 상시로 사용하고 있기 때문. 그리고 현재 오공도 상시로 사용하는 무의식의 극의를 훈련 중이다.\n 다만 이는 어디까지나 천사들이 사용하는 무의식의 극의의 특징이기 때문에 일반적인 하계인들이 천사와 똑같은 방향성으로 극의를 수련한다는 건 무리가 있는 모양. 천사들은 종족의 특성상 마음을 비우기가 쉬운 모양인지 저러한 극의를 언제든지 상시로 쓸 수 있지만, 천사가 아닌 오공이나 파괴신들은 아무래도 전투중에 사념을 비우기가 몹시 힘들기 때문. 그렇기에 우이스는 오공에게 '자신에게 맞는 방향성으로' 극의를 수련하라고 충고한다. 물론 이게 인간인 오공이 천사급의 극의를 사용할 수 없다는 의미는 아니다. 자신만의 극의를 터득하고 더욱 더 수련한다면 충분히 천사급에 도달할 수 있다. 그리고 실제로 자기만의 극의를 터득하면서 이전의 완성형 무의식의 극의마저 넘어서고 만다!")
        
        return article
    }
    
    static func getDummy2() -> Article {
        let article = Article(author: "키시모토 마사시", title: "나루토 구미 챠크라 쿠라마 모드!!!!!!", description: "나루토", url: "https://namu.wiki/w/%EA%B5%AC%EB%AF%B8%20%EC%B0%A8%ED%81%AC%EB%9D%BC%20%EB%AA%A8%EB%93%9C", urlToImage: "https://t1.daumcdn.net/cfile/tistory/277A8A3957626A7826", publishedAt: "2023-06-29", content: "나루토가 구미의 차크라를 올바른 방식으로 사용한 모습. 다른 인주력들도 요호의 옷이라 해서 미수의 힘을 인간 형태로 빌리곤 하지만, 그것과는 외양부터가 상당히 다르며 본체 대신 차크라가 실체화하여 미수화하는 방식. 전신이 밝게 빛나는 노란색의 불꽃으로 이루어진 듯한 몸에 검은색의 문양이 여럿 나있는 형태. 이 문양들은 오른팔에 있는 사상봉인의 열쇠문양과 이어져 있어서, '미수의 옷'과는 전혀 다른 이 형태가 사상봉인과 관련된게 아니냐는 말도 나왔다. 특히 미나토가 나루토에게 남기고 지라이야가 언급한 '구미 차크라를 제어하면 쓸 수 있는 술법'이 이게 아니냐는 의견도 존재.\n 미수 차크라 모드라는 이름은 팔미가 519화에서 미수옥에 대해 설명할 때 나왔고 설정집에도 명시됐으나, 작중에서도 구미 차크라 모드라는 이름을 혼용하며, 간간이 차크라 모드라고 줄여서 부르기도 함으로 나무위키에선 이 항목은 3개 모두 리다이렉트가 되어 있다.\n 선인모드는 선술을 사용한다는 것과 감지능력 대폭 상승이라는 독보적인 능력이 있어서 제4차 닌자대전 후반부에서도 종종 쓰이곤 했지만, 구미 차크라 모드는 쿠라마 모드의 하위호환이기 때문에 나루토가 쿠라마와 링크한 이후로는 굳이 사용할 이유가 없어져서 등장 끝.")
        
        return article
    }
}

extension Article: Equatable {
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id &&
            lhs.author == rhs.author &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.urlToImage == rhs.urlToImage &&
            lhs.publishedAt == rhs.publishedAt &&
            lhs.content == rhs.content
    }
}
