//
//  RecommendList.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/02.
//

import SwiftUI

struct RecommendList: View {
    let recom: [Article]
    @State private var loading: Bool = false
    
    var body: some View {
        List {
            ForEach(recom) { result in
                NavigationLink(destination: NewsDetail(articleDetail: result, loading: $loading), label:  {
                    EverythingCell(item: result)
                })
            }
            .padding(5)
        }
        .listStyle(.grouped)
    }
}


