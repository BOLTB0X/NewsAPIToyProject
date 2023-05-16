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
    
    @Published var headlinePosts = [Article]() // 연결
    
    private init() {
        //fetchArticle()
    }
    // API Key
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    
    // MARK: - Article API로 가져오는 메소드
    func fetchArticle() {
        guard let apiKey = apiKey else { return }
        print("apiKey 확인: \(apiKey)")
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(newsAPI.country)&apiKey=\(apiKey)&pageSize=\(newsAPI.pageSize)&page=\(newsAPI.page)") else { return }
        
        print("실행")
        URLSession.shared.dataTaskPublisher(for: url)
               .subscribe(on: DispatchQueue.global(qos: .background))
               .map { $0.data } // map으로 데이터 추출
               .decode(type: APIResults.self, decoder: JSONDecoder()) //  Results type으로 Decode
               .map { $0.articles } // 받아온 Results에서 articles을 추출
               .receive(on: DispatchQueue.main) // Receive를 메인으로
               .sink(receiveCompletion: { completion in // 등록
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("failure: \(error.localizedDescription)")
                       self.headlinePosts = [] // 오류가 있는 경우 post을 빈 배열로 설정
                   }
               }, receiveValue: { articles in
                   self.headlinePosts = articles // 받아온 articles을 posts에 넣어줌
                   print("api 확인: \(self.headlinePosts[0].title)")
               })
               .store(in: &cancellables)
        print("종료")
    }
}
