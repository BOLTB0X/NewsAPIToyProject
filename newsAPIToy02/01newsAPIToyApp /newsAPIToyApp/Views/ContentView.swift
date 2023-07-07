//
//  ContentView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @EnvironmentObject var manager: BookMarkManager
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Main()
                .environmentObject(manager)
            if isLoading { // 로딩 중일때 띄울거
                LaunchScreenView
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isLoading.toggle()
            })
        }
    }
}

extension ContentView {
    var LaunchScreenView: some View {
        ZStack(alignment: .center) {
            LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.gray)]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "n.circle.fill")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 200, height: 200)
                .rotationEffect(
                    Angle(
                        degrees:  self.isAnimating ? 360 : 0
                    )
                )
                .animation(
                    .linear(duration: self.isAnimating ? 1 : 0)
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BookMarkManager())
    }
}
