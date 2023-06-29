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
        HStack {
            // 이미지
            AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 180, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .scaleEffect(3.0)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 15, weight: .bold))
                    .fontWeight(.bold)
                    .bold()
                    .lineLimit(2) // 한줄로 제한
                
                Spacer()
                VStack(alignment: .leading) {
                    Spacer()
                    // 요약
                    Text(item.description ?? "")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(2)
                    Text("\(item.publishedAt)")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(4)
        }
        .padding(8)
    }
}


