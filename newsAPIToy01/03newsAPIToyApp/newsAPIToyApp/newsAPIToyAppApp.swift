//
//  newsAPIToyAppApp.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI

@main
struct newsAPIToyAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HeadLineViewModel())
        }
    }
}
