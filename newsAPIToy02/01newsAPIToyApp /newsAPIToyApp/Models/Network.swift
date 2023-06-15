//
//  Network.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import Foundation

// MARK: - NetworkManager
enum NetworkManager {
    // MARK: - 프로퍼티
    // apikey
    static var apiKey: String? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Info.plist안에 API_KEY가 연결이 안됨")
        }
        return apiKey
    }
    
    static let everythingURL:String = "https://newsapi.org/v2/everything"
   
    // 헤드라인
    static let headLineURL:String = "https://newsapi.org/v2/top-headlines"
    
    // MARK: - RequestEverythingURL
    // 요청할 URL을 반환하는 메소드
    // 파라미터 수정
    static func RequestEverythingURL(q: String? = nil, from:String? = nil, to:String?, language:String? = nil ,sortBy: String? = nil) -> URLRequest? {
        guard let apiKey = NetworkManager.apiKey else {
            fatalError("API_KEY가 설정 X\n 번들 의심")
        }
        
        let url = URL(string: everythingURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // 이제 파라미터 설정
        var queryItems: [URLQueryItem] = []
        
        // q
        if let q = q {
            queryItems.append(URLQueryItem(name: "q", value: q))
        }
        
        // from
        if let from = from {
            queryItems.append(URLQueryItem(name: "from", value: from))
        }
        
        // to
        if let to = to {
            queryItems.append(URLQueryItem(name: "to", value: to))
        }
        
        // language
        if let language = language {
            queryItems.append(URLQueryItem(name: "language", value: language))
        }
        
        // sortBy
        if let sortBy = sortBy {
            queryItems.append(URLQueryItem(name: "sortBy", value: sortBy))
        }
        
        // apiKey는 필수
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        
        // 마지막 체크
        guard let requestURL = components?.url else {
            fatalError("잘못된 URL")
        }
        
        return URLRequest(url: requestURL)
    }
    
    // MARK: - RequestHeadLineURL
    // 요청할 URL을 반환하는 메소드
    // 파라미터 수정
    static func RequestHeadLineURL(country: String? = nil, category: String? = nil, q:String? = nil, pageSize:Int? = nil, page:Int? = nil) -> URLRequest? {
        guard let apiKey = NetworkManager.apiKey else {
            fatalError("API_KEY가 설정 X\n 번들 의심")
        }
        
        let url = URL(string: headLineURL)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // 쿼리 매개변수 설정
        var queryItems: [URLQueryItem] = []
        
        // country
        if let country = country {
            queryItems.append(URLQueryItem(name: "country", value: country))
        }
        
        // category
        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        // q
        if let q = q {
            queryItems.append(URLQueryItem(name: "q", value: q))
        }
        
        if let pageSize = pageSize {
            queryItems.append(URLQueryItem(name: "pageSize", value: String(pageSize)))
        }
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        // apiKey는 필수
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        components?.queryItems = queryItems
        
        // 마지막 체크
        guard let requestURL = components?.url else {
            fatalError("URL 생성에 실패했습니다.")
        }
        
        return URLRequest(url: requestURL)
    }
}
