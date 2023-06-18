//
//  NewsDetail.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/18.
//

import SwiftUI

// TODO
struct NewsDetail: View {
    let newsDetail :Article
    @Binding var loading: Bool
    
    
    var body: some View {
        VStack {
            // 상단 타이틀 및 정보
            HStack {
                VStack(alignment: .leading) {
                    Text(newsDetail.title)
                        .font(.system(size: 25, weight: .bold))
                    Text(newsDetail.author ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(newsDetail.publishedAt)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: WebView(urlToLoad: newsDetail.url),
                            label: {
                                Text("원본 보기")
                            })
                    }
                    
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // 이미지
            CellImage(item: newsDetail, w: 400, h: 300, isTitleDisplay: false, isLoading: $loading)
            
            Text(newsDetail.content ?? "")
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct NewsDetail_Previews: PreviewProvider {
    @State static var isLoading = false
    
    static var previews: some View {
        NewsDetail(newsDetail: Article.getDummy(), loading: $isLoading)
    }
}
