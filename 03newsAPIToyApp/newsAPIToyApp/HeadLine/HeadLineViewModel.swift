//
//  HeadLineViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/11.
//

import SwiftUI

// MARK: - HeadLine ViewModel
class HeadLineViewModel: ObservableObject {
    @Published var items: [Article] = []

    init() { }
    
    // MARK: - fetchInitNewsHeadLine
    // headline 목록을 가져오는 메소스
    func fetchNewsHeadLine() async throws {
        guard let apiKey = newsAPI.apiKey else { throw fatalError("Info.plist안에 API_KEY가 연결이 안됨") }
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=\(apiKey)") else {
             throw fatalError("invalidURL")
         }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            items = []
            return
        }
        
        do {
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.items = apiResult.articles
            }
        } catch(let err) {
            throw fatalError("invalidURL")
        }
    }
}
