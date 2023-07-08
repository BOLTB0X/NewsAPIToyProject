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
    
    var body: some View {
        ZStack {
            if isLoading { // 로딩 중일때 띄울거
                CnimationCircle()
            } else {
                Main()
                    .environmentObject(manager)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isLoading.toggle()
            })
        }
    }
}

struct CnimationCircle: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Image(systemName: "n.circle.fill")
            .resizable()
            .foregroundColor(.black)
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .scaleEffect(animationAmount)
                //animationAmount가 1이면 불트명이 1이고, 2이면 불투명도가 0이다
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)))
            .onAppear {
                self.animationAmount = 2
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BookMarkManager())
    }
}
