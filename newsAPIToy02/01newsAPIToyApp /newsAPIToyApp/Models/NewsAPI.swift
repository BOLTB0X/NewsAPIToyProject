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
struct Article: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
