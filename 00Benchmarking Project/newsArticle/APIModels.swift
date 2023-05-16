//
//  APIModels.swift
//  newsArticle
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation

struct Results: Codable {
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let title: String
    let url: String
    let urlToImage: String?
}
