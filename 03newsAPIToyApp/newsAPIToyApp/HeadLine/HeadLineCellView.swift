//
//  HeadLineCellView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/17.
//

import SwiftUI

struct HeadLineCellView: View {
    let curNews: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: curNews.urlToImage ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .frame(width: 150)
                }
                .scaledToFit()
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10)
            }
        }
    }
}

//struct HeadLineCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeadLineCellView()
//    }
//}
