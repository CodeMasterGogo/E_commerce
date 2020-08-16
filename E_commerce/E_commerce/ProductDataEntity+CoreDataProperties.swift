//
//  ProductDataEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductDataEntity> {
        return NSFetchRequest<ProductDataEntity>(entityName: "ProductDataEntity")
    }

    @NSManaged public var categories: NSSet?
    @NSManaged public var ranking: NSSet?

}

// MARK: Generated accessors for categories
extension ProductDataEntity {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CategoryEntity)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CategoryEntity)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

// MARK: Generated accessors for ranking
extension ProductDataEntity {

    @objc(addRankingObject:)
    @NSManaged public func addToRanking(_ value: RankingEntity)

    @objc(removeRankingObject:)
    @NSManaged public func removeFromRanking(_ value: RankingEntity)

    @objc(addRanking:)
    @NSManaged public func addToRanking(_ values: NSSet)

    @objc(removeRanking:)
    @NSManaged public func removeFromRanking(_ values: NSSet)

}
