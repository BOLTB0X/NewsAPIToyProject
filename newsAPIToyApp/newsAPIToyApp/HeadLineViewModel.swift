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
    @Published private(set) var cur = currentState()
    
    private var subscriptions = Set<AnyCancellable>() // 메모리 날리기용
    
    // MARK: - 다음 목록들 불러오기 체크
    func isPossibleFetchNext() {
        guard cur.LoadNextPage else { return }
        
        // API HeadLine 매니저 호출
        APIHeadLineManager.fetchData(page: cur.page)
        // sink로 subscriber와 publisher 연결
            .sink(receiveCompletion: onReceive, receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    // MARK: - onReceive
    // 완료 = 받아오는 경우 성공, 실패를 나눔
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break;
        case .failure:
            cur.LoadNextPage = false
        }
    }
    
    // value를 받아옴
    private func onReceive(_ batch: [Article]) {
        cur.model += batch
        cur.page += 1
        cur.LoadNextPage = batch.count == APIHeadLineManager.pageSize ? true : false
    }
}
