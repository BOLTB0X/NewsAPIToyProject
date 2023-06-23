//
//  Main.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/23.
//

import SwiftUI

struct Main: View {
    // 공식튜토리얼 스타일
    @State private var selection: Tab = .NewsMain
    
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

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
