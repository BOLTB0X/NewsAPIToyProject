//
//  Everything.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct Everything: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var everyViewModel: EverythingViewModel
    @State private var loading: Bool = false
    @State private var click: Bool = false
    
    let query: String
    
    var body: some View {
        NavigationView {
            if !everyViewModel.items.isEmpty {
                List {
                    ForEach(everyViewModel.items) { result in
                        Button(action: {
                            self.click.toggle()
                            everyViewModel.detailArticle = result
                        }) {
                            EverythingCell(item: result)
                        }
                        .sheet(isPresented: self.$click) {
                            NewsDetail(articleDetail: everyViewModel.detailArticle, loading: $loading)
                        }
                    }
                    .padding(5)
                }
                .listStyle(.inset)
                .navigationTitle("\(query)")
                //.navigationBarBackButtonHidden(true)
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
            } else {
                Text("Wait Please!!")
            }
        }
    }
}
