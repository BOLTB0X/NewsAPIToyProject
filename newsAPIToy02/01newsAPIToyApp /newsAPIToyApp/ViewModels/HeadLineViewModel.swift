//
//  HeadLineViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/11.
//

import SwiftUI

// MARK: - HeadLineViewModel
class HeadLineViewModel: ObservableObject {
    @Published var items: [Article] = [] // 뉴스기사들을 담을 배열
    @Published var currentPage: Int = 1 // 무한스크롤을 위한 현재 페이지
    private let articlesPerPage: Int = 5
    private var isLoading = false // 계속 불러올지 체크 변수
    
    
    init() {
        // 초기 데이터를 가져오기 위해 첫 번째 페이지 로드
        Task {
            do {
                try await fetchNewsHeadLine()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - fetchNewsHeadLine
    // headline 목록을 가져오는 메소드
    func fetchNewsHeadLine() async throws {
        guard let url = NetworkManager.RequestHeadLineURL(country: "us") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.items = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                if self.items.isEmpty {
                    self.items = apiResult.articles
                } else {
                    self.items += apiResult.articles
                }
                self.currentPage += 1
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - loadMoreNewsHeadLine
    // 계속 불러올지 체크용 메소드
    func loadMoreNewsHeadLine(currentItem: Article?) {
        guard !isLoading, let currentItem = currentItem, currentItem == items.last else {
            return
        }
        
        isLoading = true
        
        Task {
            do {
                try await fetchNewsHeadLine()
            } catch {
                print(error)
            }
            
            isLoading = false
        }
    }
}
