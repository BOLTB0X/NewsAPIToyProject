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
    static let country = "us"
    static let pageSize = 10
    static var page = 1
    // MARK: - API KEY를 여기에 다 선언하지 않은 이유
    // private을 선언할 수 없어서
//    static var apiKey: String? {
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
//            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
//        }
//        return apiKey
//    }
}
