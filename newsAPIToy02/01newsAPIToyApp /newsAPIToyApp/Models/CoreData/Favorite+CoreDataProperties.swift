//
//  Favorite+CoreDataProperties.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/27.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var urlimg: String?
    @NSManaged public var publi: String?
    @NSManaged public var conten: String?

}

extension Favorite : Identifiable {

}