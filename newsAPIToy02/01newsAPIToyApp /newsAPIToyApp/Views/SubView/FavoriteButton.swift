//
//  FavoriteButton.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        // 북마크
        Button {
            isSet.toggle()
        } label: {
            // 이미지가 변수에 따라 달라지게
            Image(systemName: isSet ? "checkmark.rectangle.portrait.fill" : "checkmark.rectangle.portrait")
                .resizable()
                .frame(width: 30, height: 40)
                .foregroundColor(.blue)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
