//
//  BookMark.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/17.
//

import SwiftUI

struct BookMark: View {
    @EnvironmentObject var manager: BookMarkManager
    @State private var loading: Bool = false
    
    var body: some View {
        NavigationView {
            List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
                ForEach(manager.items) { result in
                    NavigationLink(
                        destination: NewsDetail(articleDetail: result, loading: $loading),
                        label: {
                            BookMarkCell(item: result)
                        }
                    )
                    .navigationTitle("BookMark")
                }
            }.listStyle(.inset)
        }
    }
}

struct BookMark_Previews: PreviewProvider {
    static var previews: some View {
        BookMark()
    }
}
