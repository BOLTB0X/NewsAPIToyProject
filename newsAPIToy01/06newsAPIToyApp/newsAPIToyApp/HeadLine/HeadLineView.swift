//
//  HeadLineView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/17.
//

import SwiftUI

// MARK: - HeadLineView
// 뉴스기사를 보여주는 View
struct HeadLineView: View {
    @EnvironmentObject var headlineVM: HeadLineViewModel
    @State private var isProgressView = false
    
    var body: some View {
        NavigationView { // navigationTitle 이용 및 뷰 구성을 위해
            List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
                ForEach(headlineVM.items) { result in
                    Link(destination: URL(string: result.url)!, label: { // 해당 cell을 클릭시 원본 링크로 이동
                        HeadLineCellView(curNews: result) // 셀 구성
                    })
                    .onAppear { // onAppear를 이용하여 사용자가 터치로 밑으로 내릴때 추가로
                        // 뉴스기사(data)가 필요로 하는 지를 판단함
                        if result == headlineVM.items.last {
                            headlineVM.loadMoreNewsHeadLine(currentItem: result)
                        }
                    }
                }
                // List가 비어있을 때 로딩 표시
                if isProgressView {
                    ProgressView()
                        .padding(.vertical)
                }
            }
            .navigationTitle("News HeadLine")
        }
        // 초기 진입시 task로 비동기로 뷰에 나타낼 data를 불러오는 부분
        .task {
            do {
                isProgressView = true
                try await headlineVM.fetchNewsHeadLine()
            } catch (let error) {
                print("\(error)")
            }
            isProgressView = false
        }
    }
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineView()
            .environmentObject(HeadLineViewModel())
    }
}
