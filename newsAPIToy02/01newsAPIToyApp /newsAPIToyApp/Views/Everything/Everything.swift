//
//  Everything.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct Everything: View {
    @StateObject var everyViewModel = EverythingViewModel()
    @State private var inputText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $inputText, startSearch: {
                    Task {
                        do {
                            try await everyViewModel.fetchNewsEverythingOnServer(query: inputText)
                        } catch {
                            // 오류 처리
                            print("Error: \(error)")
                        }
                    }
                })
                
                if !everyViewModel.items.isEmpty {
                    List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
                        ForEach(everyViewModel.items) { result in
                            CardView(title: result.title, cate: result.author!, imgURL: result.urlToImage!, date: result.publishedAt)
                        }
                    }
                }
            }
        }
    }
}

struct Everything_Previews: PreviewProvider {
    static var previews: some View {
        Everything()
    }
}
