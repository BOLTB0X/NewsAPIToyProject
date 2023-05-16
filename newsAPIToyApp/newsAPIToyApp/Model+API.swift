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
//    let status: String?
//    let totalResults: Int?
    let articles: [Article]
//
//    enum CodingKeys: String, CodingKey {
//        case status, totalResults, articles
//    }

}

// MARK: - Article
struct Article: Codable, Hashable {
//    let author: String?
    let title: String
//    let description: String?
//    let url: String?
//    let urlToImage: String?
//    let publishedAt: Date?
//    let content: String?
    
//    enum CodingKeys: String, CodingKey {
//        case author, title, description, url, urlToImage, publishedAt, content
//    }

}

enum newsAPI {
    static let country = "us"
    static let pageSize = 10
    static var page = 1
}
