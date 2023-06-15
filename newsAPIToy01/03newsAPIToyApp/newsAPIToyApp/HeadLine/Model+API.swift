//
//  Model+API.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation

// MARK: - API요청으로 인한 응답: articles
struct APIResults: Codable {
//    let status: String
//    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id: UUID = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

}

// MARK: - newsAPI
enum newsAPI {
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
}
