//
//  Banner.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import SwiftUI

struct Banner: View {
    @ObservedObject var bannerViewModel = BannerViewModel.shared
    @State private var currentIndex: Int = 0
    // 타이머 이용
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            let w: CGFloat = 350
            let h: CGFloat = 200
            
            HStack {
                Text("실시간 Headline")
                    .font(.system(size: 15, weight: .bold))
                
                Spacer()
                
                // TODO
                
            }
            
            // MARK: - 베너부분
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(bannerViewModel.banners.indices, id: \.self) { i in
                        let banner = bannerViewModel.banners[currentIndex]
                        ZStack {
                            // 사진을 배경으로 설정
                            AsyncImage(url: URL(string: banner.urlToImage ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(width: w, height: h)
                                    .aspectRatio(contentMode: .fit)
                                
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: w, height: h)
                                    .aspectRatio(contentMode: .fit)
                            }
                            .padding(.horizontal)
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Spacer()
                                Text("\(banner.title)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                                    .lineLimit(2)
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: w, height: h)
                    }
                }
            }
            .frame(width: w, height: h)
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % bannerViewModel.banners.count // 다음 헤드라인으로 이동
                }
            }
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
