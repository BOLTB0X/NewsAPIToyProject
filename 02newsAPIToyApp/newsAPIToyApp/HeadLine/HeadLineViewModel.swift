//
//  HeadLineViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/11.
//

import SwiftUI
import Combine

// MARK: - HeadLine ViewModel
class HeadLineViewModel: ObservableObject {
    // 싱글톤 적용
    static let shared = HeadLineViewModel()
    var cancellables = Set<AnyCancellable>() // 메모리 날리기 용
    
    @Published private(set) var state = curState()
    
    private init() {
        //fetchArticle()
    }

    // MARK: - Article API를 스크롤 내릴때마다 호출되는 메소드
    func fetchNextArticle() {
        guard state.canLoadNext else { return } // 호출 가능한지 체크
        
        // 만들어든 api메소드 호출
        newsAPI.fetchHeadLine(country: "us", page: state.page)
            .sink(receiveCompletion: onReceive, receiveValue: onReceive)
            .store(in: &cancellables)
    }
    // 실패, 성공 경우를 나눔
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("failure: \(error.localizedDescription)")
            state.canLoadNext = false
        }
    }
    
    // receive 부분
    private func onReceive(_ arti: [Article]) {
        state.headlineArticle += arti
        state.page += 1
        state.canLoadNext = arti.count == newsAPI.pageSize ? true : false
    }
    
    // MARK: - curState : 현재 뉴스 기사들의 상태를 나타냄
    struct curState {
        var headlineArticle: [Article] = []
        var page: Int = 1
        var canLoadNext:Bool = true
    }
}
