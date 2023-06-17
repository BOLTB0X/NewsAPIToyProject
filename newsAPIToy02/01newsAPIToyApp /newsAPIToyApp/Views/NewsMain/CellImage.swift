//
//  CellImage.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/16.
//

import SwiftUI

// MARK: - CellImage
// 이미지와 제목
struct CellImage: View {
    let item: Article
    let w:CGFloat
    let h:CGFloat
    @Binding var isLoading:Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            // 사진을 배경으로 설정
            AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                image
//                    .renderingMode(.original)
                    .resizable()
                    .frame(width: w, height: h)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                
            } placeholder: {
                Image(systemName: "photo")
//                    .renderingMode(.original)
                    .resizable()
                    .frame(width: w, height: h)
                    .aspectRatio(contentMode: .fit)
                    .redacted(reason: .placeholder)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            
            if !isLoading {
                Text("\(item.title)")
                    .lineLimit(1)
            } else {
                Text("\(item.title)")
                    .lineLimit(1)
                    .redacted(reason: .placeholder)
            }
        }
        //.frame(width: w, height: h)
    }
}


