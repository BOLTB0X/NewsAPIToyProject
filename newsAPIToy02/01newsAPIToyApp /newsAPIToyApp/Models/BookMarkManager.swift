//
//  BookMarkViewModel.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/28.
//

import Foundation
import CoreData

// MARK: - BookMarkManager
// 북마크 관련 처리
class BookMarkManager: ObservableObject {
    @Published var items: [Article] = []
    
    init() {
        fetchFavoriteOnCore()
    }
    
    // MARK: - fetchFavoriteOnCore
    func fetchFavoriteOnCore() {
        // 코어 데이터에서 Favorite을 가져와 items 배열에 추가
        let context = CoreDataManager.shared.favoriteContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            let articles = favorites.compactMap { favorite in
                // 각 Favorite 프로퍼티들을 Article로 변환
                Article(author: favorite.author ?? "", title: favorite.title ?? "", description: favorite.description, url: favorite.url ?? "", urlToImage: favorite.urlimg ?? "", publishedAt: favorite.publi ?? "", content: favorite.conten ?? "", favorite: favorite.favorite)
            }
            items = articles
        } catch {
            print("Favorite 항목 가져오기 실패: \(error)")
        }
    }
    
    
    // MARK: - fetchFavorite
    // Article에 해당하는 Favorite 엔티티를 가져오는 메소드
    func fetchFavorite(_ article: Article) -> Favorite? {
        let context = CoreDataManager.shared.favoriteContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", article.title)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.first
        } catch {
            print("실패 원인인 에러: \(error)")
            return nil
        }
    }
    
    // MARK: - isBookmarked
    // 이미 들어가 있는지 체크
    func isBookmarked(_ article: Article) -> Bool {
        return items.contains(article)
    }
    
    // MARK: - toggleBookmark
    // 토글 메소드
    func toggleBookmark(_ article: Article) {
        if isBookmarked(article) { // 이미 북마크가 되어 있는 경우
            if let favorite = fetchFavorite(article) {
                CoreDataManager.shared.deleteFavorite(favorite: favorite)
            }
            items.removeAll(where: { $0 == article })
        } else {
            // 북마크가 되어 있지 않은 경우
            items.append(article)
            CoreDataManager.shared.saveFavorite(
                title: article.title,
                url: article.url,
                description: article.description,
                author: article.author,
                urlimg: article.urlToImage,
                publi: article.publishedAt,
                conten: article.content
            )
        }
    }
}
