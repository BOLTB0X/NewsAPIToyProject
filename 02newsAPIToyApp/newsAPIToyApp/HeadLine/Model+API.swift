//
//  Model+API.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation
import Combine


// MARK: - API요청으로 인한 응답: articles
struct APIResults: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    //let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

}

enum newsAPI {
    static let pageSize:Int = 3
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
    
    // MARK: - fetchHeadLine(API 호출): 헤드라인 기사 가져오기
    static func fetchHeadLine(country: String, page: Int) -> AnyPublisher<[Article], Error> {
        guard let apiKey = apiKey else { fatalError("Info.plist안에 API_KEY가 연결이 안됨") }
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(apiKey)&pageSize=\(Self.pageSize)&page=\(page)") else { fatalError("Invalid URL") }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { $0.data } // map으로 데이터 추출
            .decode(type: APIResults.self, decoder: JSONDecoder()) //  Results type으로 Decode
            .map { $0.articles } // 받아온 Results에서 articles을 추출
            .receive(on: DispatchQueue.main) // Receive를 메인으로
            .eraseToAnyPublisher()
    }
}
