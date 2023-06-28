//
//  BookMarkCell.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/28.
//

import SwiftUI

struct BookMarkCell: View {
    let item: Article
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    // 제목
                    Text(item.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(2)
                    HStack(spacing: 15) {
                        Text(item.author ?? "")

                        Text(item.publishedAt)
                    }
                    .lineLimit(1)

                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                Spacer()
            }

            // 이미지
            AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .scaleEffect(5.0)
            }
//            .scaledToFit()
            .frame(width: 350, height: 300)
            .clipped()
            .cornerRadius(10)
            
            // 요약
            Text(item.description ?? "")
                .foregroundColor(.black)
                .lineLimit(3)
        }
    }
}


