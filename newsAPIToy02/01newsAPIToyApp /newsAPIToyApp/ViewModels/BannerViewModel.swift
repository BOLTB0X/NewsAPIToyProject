//
//  NannerViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/15.
//

import Foundation

// MARK: - BannerViewModel
class BannerViewModel: ObservableObject {
    static let shared = BannerViewModel() // 싱글톤
    @Published var banners: [Article] = [] // 뉴스기사들을 담을 배열
    
    // 외부에서 할 일이 없어
    private init() {
        Task {
            do {
                try await fetchBannerData()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - fetchBannerData
    func fetchBannerData() async throws {
        guard let url = NetworkManager.RequestHeadLineURL(country: "us", pageSize: 5, page: 1) else {
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
}
