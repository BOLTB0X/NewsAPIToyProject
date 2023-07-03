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
    
    @Published var searchItems: [Search] = []
    
    init() {
        fetchSearch()
    }
    
    // MARK: - fetchSearch
    func fetchSearch() {
        let fetchRequest: NSFetchRequest<Search> = Search.fetchRequest()
        
        do {
            let context = CoreDataManager.shared.searchContainer.viewContext
            searchItems = try context.fetch(fetchRequest)
        } catch {
            print("검색기록 가져오기 실패")
        }
    }
}
