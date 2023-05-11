//
//  Model+API.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation
import Combine


// MARK: - API요청으로 인한 응답: articles
struct APIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

// MARK: - ViewModel에 연결할 모델
struct currentState {
    var model: [Article] = []
    var page: Int = 1
    var LoadNextPage: Bool = true
}

// MARK: - API HeadLine manager
class APIHeadLineManager {
    // APIKey를 한 번만 로드하고 앱 수명 주기 내내 재사용하고자 하기 때문입니다. 그렇게 하면 fetchData를 호출할 때마다 APIKey를 다시 로드할 필요가 없게끔, 싱글톤 적용
    static let pageSize = 5
    
    // config파일에 설정에 놓은 api key를 가져옴
    private let apiKey: String
    
    
    // 초기화
    private init() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Wrong apiKey~~~~")
        }
        
        self.apiKey = apiKey
    }
    
    // MARK: - fetchData: API로 data를 가져오는 메소드
    func fetchData(page: Int) -> AnyPublisher<[Article], Error> {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)&pageSize=\(Self.pageSize)&page=\(page)")!
        
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
            //.subscribe(on: DispatchQueue.global(qos: .background)) // 가져오는 것은 백그라운드로 설정
        // try 키워드를 사용하여 오류가 발생하면 해당 오류를 내보내도록 설정
            .tryMap { try JSONDecoder().decode(APIResponse.self, from: $0.data).articles }
            .receive(on: DispatchQueue.main) // 받는 것 메인
            .eraseToAnyPublisher()
    }
}
