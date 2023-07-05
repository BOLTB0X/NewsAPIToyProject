//
//  EverythingViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import Foundation

// MARK: - EverythingViewModel
class EverythingViewModel: ObservableObject {
    @Published var items: [Article] = [] // 뉴스기사들을 담을 배열
    
    // main 에 넣을 프로퍼티
    @Published var bitcoins: [Article] = []
    @Published var teslas: [Article] = []
    @Published var aespa: [Article] = []
    
    @Published var detailArticle: Article = Article.getDummy()
    @Published var isTry: Bool = false
    
    private let articlesPerPage: Int = 5
    private var isLoading = false // 계속 불러올지 체크 변수
    
    
    init() {

    }
    
    // MARK: - fetchNewsEverythingOnServer
    // headline 목록을 가져오는 메소드
    func fetchNewsEverythingOnServer(query: String) async throws {
        guard let url = NetworkManager.RequestEverythingURL(q: query) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.items = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
    
                    self.items = apiResult.articles
             
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - fetchPostBit
    // 메인 뷰에 게시할
    func fetchPostBit() async throws {
        guard let url = NetworkManager.RequestEverythingURL(q: "bitcoins", sortBy: "popularity") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.bitcoins = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.bitcoins = apiResult.articles
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - fetchPostTes
    // 메인 뷰에 게시할
    func fetchPostTes() async throws {
        guard let url = NetworkManager.RequestEverythingURL(q: "tesla", sortBy: "popularity") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.teslas = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.teslas = apiResult.articles
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - fetchPostAe
    // 메인 뷰에 게시할
    func fetchPostAe() async throws {
        guard let url = NetworkManager.RequestEverythingURL(q: "aespa", sortBy: "popularity") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.aespa = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.aespa = apiResult.articles
            }
        } catch {
            throw error
        }
    }
}
