//
//  HeadLineView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/16.
//

import SwiftUI

struct HeadLineView: View {
    @ObservedObject var headlines = HeadLineViewModel.shared
    var body: some View {
        NavigationView{
            List{
                ForEach(headlines.headlinePosts, id: \.self) { result in
                    Text(result.title)
                        .bold()
                }
            }.navigationTitle("뉴스 헤드라인")
        }.onAppear {
            headlines.fetchArticle()
        }
    }
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineView()
    }
}
