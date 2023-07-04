//
//  Search.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/03.
//

import SwiftUI

struct SearchMain: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var searchViewModel = SearchViewModel()
    @EnvironmentObject var newsViewModel: NewsMainViewModel
    @StateObject var everyViewModel = EverythingViewModel()
    
    @State private var click: Bool = false
    @State private var loading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchViewModel.inputText, startSearch: {
                    Task {
                        do {
                            try await everyViewModel.fetchNewsEverythingOnServer(query: searchViewModel.inputText)
                        } catch {
                            // 오류 처리
                            print("Error: \(error)")
                        }
                    }
                })
                
                List(searchViewModel.filteredArticles, id: \.url) { article in
                    Button(action: {
                        self.click.toggle()
                        searchViewModel.detailArticle = article
                    }) {
                        Text(article.title)
                            .lineLimit(2)
                    }
                    .sheet(isPresented: self.$click) {
                        NewsDetail(articleDetail: searchViewModel.detailArticle, loading: $loading)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Search")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                    }
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
