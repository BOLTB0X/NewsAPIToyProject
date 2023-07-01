//
//  Banner.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import SwiftUI

struct Banner: View {
    @EnvironmentObject var BannerViewModel: NewsMainViewModel
    @State private var currentIndex: Int = 0
    @State private var loading: Bool = false
    
    // 타이머 이용
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let w: CGFloat = 400
            let h: CGFloat = 250
            
            // MARK: - 베너부분
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(BannerViewModel.banners.indices, id: \.self) { i in
                        let banner = BannerViewModel.banners[currentIndex]
                        ZStack {
                            // 사진을 배경으로 설정
                            AsyncImage(url: URL(string: banner.urlToImage ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(width: w, height: h)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: w, height: h)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                    .redacted(reason: .placeholder)
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Current HeadLine")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                                //                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Text("\(banner.title)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                                    .lineLimit(2)
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: w, height: h)
                        
                        .navigationBarTitleDisplayMode(.inline)
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
                    //currentIndex = (currentIndex + 1) % BannerViewModel.banners.count // 다음 헤드라인으로 이동
                }
            }
        }
    }
}

//struct Banner_Previews: PreviewProvider {
//    static var previews: some View {
//        Banner()
//    }
//}
