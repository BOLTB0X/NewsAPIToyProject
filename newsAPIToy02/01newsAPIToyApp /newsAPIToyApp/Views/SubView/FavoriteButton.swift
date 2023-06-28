//
//  FavoriteButton.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var bookmarkManager: BookMarkManager
    var item: Article

    var isSet: Bool {
        bookmarkManager.isBookmarked(item)
    }
    
    var body: some View {
        // 북마크
        Button {
            bookmarkManager.toggleBookmark(item)
        } label: {
            // 이미지가 변수에 따라 달라지게
            Image(systemName: isSet ? "checkmark.rectangle.portrait.fill" : "checkmark.rectangle.portrait")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.blue)
        }
    }
}

