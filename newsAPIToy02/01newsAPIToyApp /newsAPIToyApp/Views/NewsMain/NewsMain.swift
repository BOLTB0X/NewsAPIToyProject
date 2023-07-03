//
//  NewsMain.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import SwiftUI

struct NewsMain: View {
    @ObservedObject var newsMainViewModel = NewsMainViewModel.shared
    
    var body: some View {
        NavigationView {
            List {
                Banner()
                    .environmentObject(newsMainViewModel)
                    .padding(.horizontal)
                
                RecommendRow(title: "Hot issue", recom: newsMainViewModel.recom1, loading: $newsMainViewModel.loadingRecommend1)
                 
                RecommendRow(title: "Movie", recom: newsMainViewModel.recom2, loading: $newsMainViewModel.loadingRecommend2)
                  
                RecommendRow(title: "K-pop", recom: newsMainViewModel.recom3, loading: $newsMainViewModel.loadingRecommend3)
                    
                RecommendRow(title: "Shose", recom: newsMainViewModel.recom4, loading: $newsMainViewModel.loadingRecommend4)
            }
            .listStyle(.inset)
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HeadLine()) {
                        Image(systemName: "h.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchMain()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
}

//struct NewsMain_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsMain()
//    }
//}
