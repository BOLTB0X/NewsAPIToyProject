//
//  HeadLineView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/17.
//

import SwiftUI

struct HeadLineView: View {
    @EnvironmentObject var headlineVM: HeadLineViewModel
    
    var body: some View {
        NavigationView{
            List{
                ForEach(headlineVM.items) { result in
                    Text(result.title)
                }
            }.navigationTitle("뉴스 헤드라인")
        }.task {
            do {
                try await headlineVM.fetchNewsHeadLine()
            } catch (let error) {
                print("\(error)")
            }
        }
    }
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineView()
            .environmentObject(HeadLineViewModel())
    }
}
