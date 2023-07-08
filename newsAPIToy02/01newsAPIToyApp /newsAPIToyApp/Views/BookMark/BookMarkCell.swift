//
//  BookMarkCell.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/28.
//

import SwiftUI

struct BookMarkCell: View {
    let item: Article
    @State private var imgLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: item.urlToImage!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imgLoading = true // 가리기 취소
                    }
                
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .redacted(reason: .placeholder)
                    .onAppear {
                        imgLoading = false // 가리기
                    }
            }
            HStack {
                VStack(alignment: .leading) {
                    if !imgLoading {
                        Text("Loading....................")
                            .font(.headline)
                            .lineLimit(1)
                            .redacted(reason: .placeholder)
                        
                        Text("Loading.....................")
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(1)
                            .redacted(reason: .placeholder)
                        
                        Text("Loading...................")
                            .lineLimit(1)
                            .font(.subheadline)
                            .redacted(reason: .placeholder)
                        
                    } else {
                        Text(item.author ?? "")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(item.title)
                            .font(.system(size: 20, weight: .bold))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Text(item.content ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                }
                .layoutPriority(100)
                
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

