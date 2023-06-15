//
//  ContentView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var headlineVM = HeadLineViewModel()

    var body: some View {
        HeadLineView()
            .environmentObject(headlineVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
