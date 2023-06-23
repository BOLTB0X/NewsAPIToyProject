//
//  ContentView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Main()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
