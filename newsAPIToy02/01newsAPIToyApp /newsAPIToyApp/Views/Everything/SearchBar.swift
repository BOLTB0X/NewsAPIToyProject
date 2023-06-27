//
//  SearchBar.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/27.
//

import SwiftUI

// MARK: - SearchBar
// 원본: https://www.appcoda.com/swiftui-search-bar/
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    var startSearch: () -> Void // 검색 버튼 클릭하면 동작할 클로저
    
    var body: some View {
        HStack {
            TextField("검색", text: $text, onCommit: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 원하는 날짜 형식으로 설정
                let datetimeString = dateFormatter.string(from: Date())
                
                CoreDataManager.shared.saveSearchHistory(text: text, datetime: datetimeString)
                startSearch() // 뷰모델의 메소드로 검색 수행
            })
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
            
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), startSearch: {})
    }
}
