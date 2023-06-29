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
    @State private var loading: Bool = false
    
    var body: some View {
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
                List {
                    ForEach(everyViewModel.items) { result in
                        NavigationLink(destination: NewsDetail(articleDetail: result, loading: $loading), label:  {
                            EverythingCell(item: result)
                        })
                    }
                    .padding(5)
                }
                .listStyle(.grouped)
            } else {
                Spacer()
                Text("Please!!")
                Spacer()
            }
        }
    }
}

struct Everything_Previews: PreviewProvider {
    static var previews: some View {
        Everything()
    }
}
