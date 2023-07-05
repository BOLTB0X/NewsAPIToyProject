//
//  SearchViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/03.
//

import Foundation
import CoreData

// MARK: - SearchViewModel
class SearchViewModel: ObservableObject {
    static let shared = SearchViewModel()
    
    @Published var inputText: String = ""
    @Published var detailArticle: Article = Article.getDummy()
    
    init() {
        
    }
    
    var filteredArticles: [Article] {
        let searchText = inputText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // banners, recom1, recom2, recom3, recom4에서 필터링
        let allArticles = NewsMainViewModel.shared.banners + NewsMainViewModel.shared.recom1 + NewsMainViewModel.shared.recom2 + NewsMainViewModel.shared.recom3 + NewsMainViewModel.shared.recom4

        if searchText.isEmpty {
            // 검색어가 없는 경우 전체 기사 반환
            return allArticles
        } else {
            // 검색어가 있는 경우 기사들 중 제목에 검색어가 포함된 것만 반환
            return allArticles.filter { $0.title.lowercased().contains(searchText) == true }
        }
    }
}
