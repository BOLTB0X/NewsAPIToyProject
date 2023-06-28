//
//  NewsDetail.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/18.
//

import SwiftUI

// MARK: - NewsDetail
// 뉴스기사 상세 뷰
struct NewsDetail: View {
    @EnvironmentObject var manager: BookMarkManager // 북마크
    let articleDetail: Article // 뉴스 기사
    @Binding var loading: Bool // 로딩
    
    var body: some View {
        VStack {
            // 상단 타이틀 및 정보
            HStack {
                VStack(alignment: .leading) {
                    Text(articleDetail.title)
                        .font(.system(size: 25, weight: .bold))
                    Text(articleDetail.author ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(articleDetail.publishedAt)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        FavoriteButton(item: articleDetail)
                            .environmentObject(manager)
                        
                        NavigationLink(
                            destination: WebView(urlToLoad: articleDetail.url),
                            label: {
                                Text("원본 보기")
                            })
                    }
                    
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // 이미지
            CellImage(item: articleDetail, w: 400, h: 300, isTitleDisplay: false, isLoading: $loading)
            
            Text(articleDetail.content ?? "")
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static let bookMarkManager = BookMarkManager()
    
    static var previews: some View {
        let article = Article.getDummy()
        
        bookMarkManager.items.append(article)
        
        return NewsDetail(articleDetail: article, loading: .constant(false))
            .environmentObject(bookMarkManager)
    }
}
