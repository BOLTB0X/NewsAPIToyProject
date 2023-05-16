//
//  ContentView.swift
//  newsArticle
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var network = RequestAPI.shared
    
    var body: some View {
        NavigationView{
            List{
                ForEach(network.posts, id: \.self) { result in
                    Text(result.title)
                        .bold()
                }
            }.navigationTitle("뉴스 헤드라인")
        }.onAppear {
            network.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
