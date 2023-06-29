//
//  EverythingCell.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/29.
//

import SwiftUI

struct EverythingCell: View {
    let item: Article
    @State private var imgLoading:Bool = false
    
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
                    .onAppear {
                        imgLoading = true
                    }
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .frame(width: 180, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imgLoading = false // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
            if imgLoading {
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
            } else {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .fontWeight(.bold)
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(2) // 한줄로 제한
                        .redacted(reason: .placeholder)
                    
                    Spacer()
                    VStack(alignment: .leading) {
                        Spacer()
                        // 요약
                        Text(item.description ?? "")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .redacted(reason: .placeholder)
                        
                        Text("\(item.publishedAt)")
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .redacted(reason: .placeholder)
                    }
                    Spacer()
                }
                .padding(4)
            }
        }
        .padding(8)
        
    }
}

