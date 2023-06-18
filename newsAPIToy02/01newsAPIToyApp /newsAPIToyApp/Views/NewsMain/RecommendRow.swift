//
//  RecommendRow.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/17.
//

import SwiftUI

// MARK: - RecommendRow
struct RecommendRow: View {
    let title: String
    let recom: [Article]
    
    @Binding var loading: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(title)")
                .font(.headline)
                .padding(.leading, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(recom, id: \.self) { recom in
                        NavigationLink(
                            destination: NewsDetail(newsDetail: recom, loading: $loading),
                            label: {
                                CellImage(item: recom, w: 155, h: 155, isTitleDisplay: true, isLoading: $loading)
                            })
                    }
                }
                .frame(height: 185)
            }
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
        }
    }
}

//struct RecommendRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendRow()
//    }
//}
