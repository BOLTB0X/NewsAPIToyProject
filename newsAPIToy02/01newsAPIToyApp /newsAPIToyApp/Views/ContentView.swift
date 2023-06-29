//
//  ContentView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    // init이용을 위해
    @StateObject var manager = BookMarkManager()
    
    var body: some View {
        ZStack {
            Main()
            .environmentObject(manager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
