//
//  listView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/15.
//

import SwiftUI
import Combine

struct listView: View {
    @ObservedObject var headline: HeadLineViewModel
    
    var body: some View {
        HeadlineList(articles: headline.cur.models, isLoading: headline.cur.LoadNextPage, onScrolledAtBottom: headline.isPossibleFetchNext)
    }
}

struct HeadlineList: View {
    let articles: [Article]
    let isLoading:Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        List {
            articleList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var articleList: some View {
        ForEach(articles) { article in
            Text(article.title)
                .onAppear {
                    
                    if self.articles.last == article {
                        self.onScrolledAtBottom()
                    }
                }
        }
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        listView(headline: HeadLineViewModel())
    }
}
