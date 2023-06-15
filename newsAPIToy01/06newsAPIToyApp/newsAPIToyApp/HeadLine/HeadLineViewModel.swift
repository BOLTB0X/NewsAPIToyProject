//
//  HeadLineViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/05/11.
//

import SwiftUI

// MARK: - HeadLine ViewModel
class HeadLineViewModel: ObservableObject {
    @Published var items: [Article] = [] // 뉴스기사들을 담을 배열
    @Published var currentPage:Int = 1 // 무한스크롤을 위한 
    private let articlesPerPage:Int = 5
    private var isLoading = false // 계속 불러올지 체크 변수
    
    init() {
    }
    
    // MARK: - fetchInitNewsHeadLine
    // headline 목록을 가져오는 메소스
    func fetchNewsHeadLine() async throws {
        guard let apiKey = newsAPI.apiKey else { throw fatalError("Info.plist안에 API_KEY가 연결이 안됨") }
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&pageSize=\(articlesPerPage)&page=\(currentPage)&apiKey=\(apiKey)") else {
            throw fatalError("invalidURL")
        }
        
        // MARK: - 리팩토링
        Task { // Task를 통해 비동기 작업을 생성
            // URLSession으로 raw한 data를 받아오는 부분을 do-catch 블록으로 감쌈
            do {
                // 메서드를 비동기로 호출, await 키워드를 사용하여 데이터가 반환될 때까지 대기
                let (data, response) = try await URLSession.shared.data(from: url)
                // 받은 응답 객체를 HTTPURLResponse로 캐스팅하고, 상태 코드가 200인지 확인
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    DispatchQueue.main.async {
                        self.items = []
                    }
                    return // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화하고 함수를 종료
                }
                // 받아온 데이터를 APIResults 타입으로 디코딩 후 apiResult에 넣어줌
                let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
                // 메인 큐로 복귀, UI 업데이트를 수행하기 위해 비동기적으로 메인 큐에 작업을 추가
                DispatchQueue.main.async {
                    if self.items.isEmpty {
                        self.items = apiResult.articles
                    } else {
                        self.items += apiResult.articles
                    }
                    self.currentPage += 1 // 현재 페이지 증가
                    print(self.currentPage)
                }
            } catch(let error) {
                print(error)
            }
        }
    }
    
    // MARK: - loadMoreNewsHeadLine
    // 계속 불러올지 체크용 메소드
    func loadMoreNewsHeadLine(currentItem: Article?) {
        // false이면 그냥 넘어가기
        guard !isLoading, let currentItem = currentItem, currentItem == items.last else {
            return
        }
        
        isLoading = true // 호출
        
        // 기존 방식과 동일
        Task {
            do {
                try await fetchNewsHeadLine()
            } catch(let error) {
                print(error)
            }
            
            isLoading = false
        }
    }
}
