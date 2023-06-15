//
//  HeadLineView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/16.
//

import SwiftUI

struct HeadLineListContainer: View {
    @ObservedObject var headlines = HeadLineViewModel.shared
    
    var body: some View {
        HeadLineList(article: headlines.state.headlineArticle, isLoading: headlines.state.canLoadNext, onScrolledAtBottom: headlines.fetchNextArticle
        )
            .onAppear(perform: headlines.fetchNextArticle)
    }
}

struct HeadLineList: View {
    let article: [Article]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        LazyVStack {
            ForEach(article, id: \.self) { arti in
                headlineCell(headline: arti)
                    .onAppear {
                        if self.article.last == arti {
                            self.onScrolledAtBottom()
                        }
                    }
            }
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineListContainer()
    }
}
