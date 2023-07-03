//
//  Search.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/03.
//

import SwiftUI

struct SearchMain: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    @StateObject var everyViewModel = EverythingViewModel()
    
    @State private var inputText: String = ""
    @State private var loading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $inputText, startSearch: {
                    Task {
                        do {
                            
                            try await everyViewModel.fetchNewsEverythingOnServer(query: inputText)
                        } catch {
                            // 오류 처리
                            print("Error: \(error)")
                        }
                    }
                    CoreDataManager.shared.saveSearchHistory(text: inputText, datetime: "")
                })
                
                List {
                    ForEach(searchViewModel.searchItems) { result in
                        Text(result.text ?? "")
                    }
                }
                
            }
            .listStyle(.inset)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   
                }
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchMain()
    }
}
