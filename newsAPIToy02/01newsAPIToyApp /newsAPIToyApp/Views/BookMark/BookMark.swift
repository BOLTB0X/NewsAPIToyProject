//
//  BookMark.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/17.
//

import SwiftUI

struct BookMark: View {
    @EnvironmentObject var bookmarkManager: BookMarkManager
    
    var body: some View {
        List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
            ForEach(bookmarkManager.items) { result in
                Text(result.title)
            }
        }
    }
}

struct BookMark_Previews: PreviewProvider {
    static var previews: some View {
        BookMark()
    }
}
