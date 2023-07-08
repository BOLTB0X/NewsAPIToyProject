//
//  HeadLineCellView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/17.
//

import SwiftUI

struct HeadLineCell: View {
    let curNews: Article
    @Binding var loading:Bool
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    if loading {
                        // 제목
                        Text(curNews.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .lineLimit(2)
                        HStack(spacing: 15) {
                            Text(curNews.author ?? "")
                            
                            Text(curNews.publishedAt)
                        }
                        .lineLimit(1)
                        
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    } else {
                        // 제목
                        Text(curNews.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .redacted(reason: .placeholder)

                        HStack(spacing: 15) {
                            Text(curNews.author ?? "")
                                .redacted(reason: .placeholder)

                            Text(curNews.publishedAt)
                                .redacted(reason: .placeholder)

                        }
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }

            // 이미지
            AsyncImage(url: URL(string: curNews.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 320, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        loading = true
                    }
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .frame(width: 320, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.secondary)
                    .redacted(reason: .placeholder)
//                    .onAppear {
//                        loading = false
//                    }
            }
            
            if loading {
                // 요약
                Text(curNews.description ?? "")
                    .foregroundColor(.black)
                    .lineLimit(3)
            } else {
                Text(curNews.description ?? "")
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .redacted(reason: .placeholder)

            }
        }
    }
}

//struct HeadLineCellView_Previews: PreviewProvider {
//    static let dummy = Article(author: "dd", title: "dd", description: "3erwffdsfcsvsfcdwsxcedslvjendslvhnefjldsnfclewkdsfncklwsnfcowkldsjfncwklsfjncklwdfnlkwdnsclkwdnsfclkwdnsfcklwdnsfcklwnsflckws", url: "", urlToImage: "", publishedAt: "767858", content: "")
//    static var previews: some View {
//        HeadLineCell(curNews: dummy)
//    }
//}
