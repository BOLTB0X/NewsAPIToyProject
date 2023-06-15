//
//  HeadLineCellView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/17.
//

import SwiftUI

struct HeadLineCellView: View {
    let curNews: Article
    @State private var showContent = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            // MARK: - 기사 제목, 저자, 발행일
            VStack(alignment: .leading) {
                Text(curNews.title)
                    .font(.headline)
                HStack(spacing: 5) {
                    Text(curNews.author ?? "")
                    Text(curNews.publishedAt)
                    
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            
            // MARK: - 이미지
            AsyncImage(url: URL(string: curNews.urlToImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .frame(width: 400)
            }
            .scaledToFit()
            .frame(width: 400, height: 400)
            .clipped()
            .cornerRadius(10)
            
            // MARK: - 기사 내용
            // 클릭 시 원본 링크로 이동
            Link(destination: URL(string: curNews.url)!, label: {
                Text(curNews.description ?? "" )
                    .foregroundColor(.black)
            })
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

