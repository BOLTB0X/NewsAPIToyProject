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
            .map { $0.data } // Extract the data from the response
            .decode(type: Results.self, decoder: JSONDecoder()) // Decode the data into the Results type
            .map { $0.articles } // Extract the articles from the Results
            .receive(on: DispatchQueue.main) // Receive the output on the main thread
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.posts = [] // Set the posts to an empty array if there is an error
                }
            }, receiveValue: { articles in
                self.posts = articles // Update the posts with the received articles
            })
            .store(in: &cancellables)
    }
}
