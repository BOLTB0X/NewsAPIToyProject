//
//  RecommendList.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/07/02.
//

import SwiftUI

struct RecommendList: View {
    @Environment(\.presentationMode) var presentationMode
    let title:String
    let recom: [Article]
    @State private var loading: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recom) { result in
                    NavigationLink(destination: NewsDetail(articleDetail: result, loading: $loading), label:  {
                        EverythingCell(item: result)
                    })
                }
                .padding(5)
            }
            .listStyle(.inset)
            .navigationTitle("\(title)")
//            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
    }
}


