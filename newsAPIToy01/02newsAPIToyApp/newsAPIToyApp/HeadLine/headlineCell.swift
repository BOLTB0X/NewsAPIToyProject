//
//  headlineCell.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/16.
//

import SwiftUI

struct headlineCell: View {
    let headline: Article
    
    var body: some View {
        VStack {
            Text(headline.title)
                .lineLimit(2)
                .multilineTextAlignment(.center) //여러줄의 텍스트 표시 정렬방식
                    .lineSpacing(50) //텍스트 줄간격 조절
            HStack {
                Text(headline.author!)
                    .lineLimit(1)
                Text(headline.publishedAt)
                    .lineLimit(1)
            }
        }
    }
}

