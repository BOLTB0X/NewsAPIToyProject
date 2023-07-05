//
//  NewsMainViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/16.
//

import Foundation

// MARK: - NewsMainViewModel
class NewsMainViewModel:ObservableObject {
    static let shared = NewsMainViewModel()
    @Published var banners: [Article] = [] // 뉴스기사들을 담을 배열
    @Published var recom1: [Article] = []
    @Published var recom2: [Article] = []
    @Published var recom3: [Article] = []
    @Published var recom4: [Article] = []
    
    // 추천 검색어 api는 일단 random으로 대체
    let radomArr1 = ["Bitcoin", "MMA", "Meta", "LOL"]
    let radomArr2 = ["shinkai makoto", "across the spider verse", "oldboy", "spiderman"]
    let radomArr3 = ["Kpop BTS", "Kpop SM", "Aespa", "KPop"] // entertainment
    let radomArr4 = ["Nike", "adidas", "Puma", "asics"]
    var query: String

    // 로딩 표현
    @Published var loadingBanner: Bool = false // 로딩 상태를 나타내는 퍼블리셔드
    @Published var loadingRecommend1: Bool = false
    @Published var loadingRecommend2: Bool = false
    @Published var loadingRecommend3: Bool = false
    @Published var loadingRecommend4: Bool = false
    
    private init() {
        query = ""
        Task {
            do {
                loadingBanner = true
                try await fetchBannerData()
                loadingBanner = false
                
                loadingRecommend1 = true
                try await fetchPostRecommend(series: 1)
                loadingRecommend1 = false
                
                loadingRecommend2 = true
                try await fetchPostRecommend(series: 2)
                loadingRecommend2 = false
                
                loadingRecommend3 = true
                try await fetchPostRecommend(series: 3)
                loadingRecommend3 = false
                
                loadingRecommend4 = true
                try await fetchPostRecommend(series: 4)
                loadingRecommend4 = false
            } catch {
                print(error)
            }
            
        }
    }
    
    //MARK: - fetchBannerData
    func fetchBannerData() async throws {
        guard let url = NetworkManager.RequestHeadLineURL(country: "us", pageSize: 3, page: 1) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.banners = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                self.banners = apiResult.articles
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - fetchPostRecommend
    // 메인 뷰에 게시할
    func fetchPostRecommend(series: Int) async throws {
        
        if series == 1 { // 번호에 따라 키워드 변경
            query = radomArr1.randomElement()! // 랜덤으로 넣어줌
            print("\(query)")
        } else if series == 2 {
            query = radomArr2.randomElement()!
            print("\(query)")
        } else if series == 3 {
            query = radomArr3.randomElement()!
            print("\(query)")
        } else {
            query = radomArr4.randomElement()!
            print("\(query)")
        }
        
        // 인기순으로 가져옴
        guard let url = NetworkManager.RequestEverythingURL(q: query, sortBy: "popularity") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                    if series == 1 {
                        self.recom1 = []
                    } else if series == 2 {
                        self.recom2 = []
                    } else if series == 3{
                        self.recom3 = []
                    } else {
                        self.recom4 = []
                    }
                }
                return
            }
            let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
            DispatchQueue.main.async {
                if series == 1 {
                    self.recom1 = apiResult.articles
                } else if series == 2 {
                    self.recom2 = apiResult.articles
                } else if series == 3{
                    self.recom3 = apiResult.articles
                } else {
                    self.recom4 = apiResult.articles
                }
            }
        } catch {
            throw error
        }
    }
}
