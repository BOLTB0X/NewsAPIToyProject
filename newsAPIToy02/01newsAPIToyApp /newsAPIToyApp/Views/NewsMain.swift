//
//  NewsMain.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import SwiftUI

struct NewsMain: View {
    @ObservedObject var headlineVM = HeadLineViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Banner()
                    .padding(.horizontal)
                Spacer()
            }.navigationTitle("News")
        }
    }
}

struct NewsMain_Previews: PreviewProvider {
    static var previews: some View {
        NewsMain()
    }
}
