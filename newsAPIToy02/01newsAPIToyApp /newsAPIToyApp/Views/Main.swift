//
//  Main.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct Main: View {
    @State private var selection: Tab = .NewsMain
    // 북마크

    enum Tab {
        case NewsMain
        case BookMark
    }

    var body: some View {
        TabView(selection: $selection) {
            NewsMain()
                .tabItem {
                    Label("NewsMain", systemImage: "newspaper")
                }
                .tag(Tab.NewsMain)
            
            BookMark()
                .tabItem {
                    Label("BookMark", systemImage: "checkmark.rectangle.portrait.fill")
                }
                .tag(Tab.BookMark)
        }
    }
}

