//
//  SearchList.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/05.
//

import SwiftUI

struct SearchCell: View {
    let item: Article
    @State private var imgLoading:Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "timer.circle.fill")
            
            if imgLoading {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .bold()
                        .lineLimit(2) // 한줄로 제한
                }
                .padding(4)
                
            } else {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(2) // 한줄로 제한
                        .redacted(reason: .placeholder)
                }
                .padding(4)
            }
            
            Spacer()
            
            // 이미지
            AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(10)
                    .onAppear {
                        imgLoading = true
                    }
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        imgLoading = false // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
        }
        .padding(8)
        
    }
}
