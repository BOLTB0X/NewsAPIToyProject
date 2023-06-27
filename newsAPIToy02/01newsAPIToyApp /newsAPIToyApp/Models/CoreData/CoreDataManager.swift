//
//  CoreDataManager.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/27.
//

import Foundation
import CoreData

// MARK: - CoreDataManager
class CoreDataManager {
    static let shared = CoreDataManager()
    
    // MARK: - searchContainer
    lazy var searchContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Search")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - favoriteContainer
    lazy var favoriteContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorite")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - saveSearchHistory
    func saveSearchHistory(text: String, datetime: String) {
        let context = searchContainer.viewContext
        
        // 중복 체크
        let fetchRequest: NSFetchRequest<Search> = Search.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "text == %@", text)
        
        do {
            let searchResults = try context.fetch(fetchRequest)
            if let pastSearch = searchResults.first {
                // 이미 저장된 검색 기록이 있으면 패스
                print("이미 저장된 검색 기록입니다.")
                return
            }
        } catch {
            print("중복 체크 실패: \(error)")
            return
        }
        
        // 저장 로직
        let search = Search(context: context)
        search.text = text
        search.datetime = datetime
        
        do {
            try context.save()
            print("검색 기록 저장")
        } catch {
            print("실패한 에러: \(error)")
        }
    }
    
    // MARK: - saveFavorite
    func saveFavorite(title: String, url: String, description: String?, author: String?, urlimg: String?, publi: String, conten: String?) {
        let context = favoriteContainer.viewContext
        
        // 중복 체크
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let favoriteResults = try context.fetch(fetchRequest)
            if let pastFavorite = favoriteResults.first {
                // 이미 저장된 좋아요 한 Article이 있으면 패스
                print("이미 저장된 좋아요 한 Article")
                return
            }
        } catch {
            print("중복 체크 실패: \(error)")
            return
        }
        
        // 저장 로직
        let favorite = Favorite(context: context)
        
        favorite.id = UUID()
        favorite.title = title
        favorite.url = url
        favorite.desc = description
        favorite.author = author
        favorite.urlimg = urlimg
        favorite.publi = publi
        favorite.conten = conten
        
        do {
            try context.save()
            print("좋아요 한 Article 저장")
        } catch {
            print("실패한 에러: \(error)")
        }
    }

    // MARK: - deleteSearchHistory
    func deleteSearchHistory(search: Search) {
        let context = searchContainer.viewContext
        context.delete(search)
        
        do {
            try context.save()
            print("검색 기록 삭제")
        } catch {
            print("실패한 에러: \(error)")
        }
    }
    
    // MARK: - deleteFavorite
    func deleteFavorite(favorite: Favorite) {
        let context = favoriteContainer.viewContext
        context.delete(favorite)
        
        do {
            try context.save()
            print("Favorite 삭제")
        } catch {
            print("실패한 에러: \(error)")
        }
    }
}
