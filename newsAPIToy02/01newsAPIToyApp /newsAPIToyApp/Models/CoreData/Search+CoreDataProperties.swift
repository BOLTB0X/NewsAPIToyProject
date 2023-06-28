//
//  Search+CoreDataProperties.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/28.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var datetime: String?
    @NSManaged public var text: String?

}

extension Search : Identifiable {

}
