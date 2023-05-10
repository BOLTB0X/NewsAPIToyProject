//
//  APIManager.swift
//  newsArticle
//
//  Created by KyungHeon Lee on 2023/05/10.
//

import Foundation
import Combine

class RequestAPI: ObservableObject {
    static let shared = RequestAPI()
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var posts = [Article]()
    
    private init() {
        fetchData()
    }
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    func fetchData() {
        guard let apiKey = apiKey else { return }
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=\(apiKey)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { $0.data } // map으로 데이터 추출
            .decode(type: Results.self, decoder: JSONDecoder()) //  Results type으로 Decode
            .map { $0.articles } // 받아온 Results에서 articles을 추출
            .receive(on: DispatchQueue.main) // Receive를 메인으로
            .sink(receiveCompletion: { completion in // 등록
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.posts = [] // 오류가 있는 경우 post을 빈 배열로 설정
                }
            }, receiveValue: { articles in
                self.posts = articles // 받아온 articles을 posts에 넣어줌
            })
            .store(in: &cancellables)
    }
}
