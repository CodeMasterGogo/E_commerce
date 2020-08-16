//
//  RankingEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension RankingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RankingEntity> {
        return NSFetchRequest<RankingEntity>(entityName: "RankingEntity")
    }

    @NSManaged public var rankingType: String?
    @NSManaged public var rankingArr: NSSet?

}

// MARK: Generated accessors for rankingArr
extension RankingEntity {

    @objc(addRankingArrObject:)
    @NSManaged public func addToRankingArr(_ value: ProductRankingEntity)

    @objc(removeRankingArrObject:)
    @NSManaged public func removeFromRankingArr(_ value: ProductRankingEntity)

    @objc(addRankingArr:)
    @NSManaged public func addToRankingArr(_ values: NSSet)

    @objc(removeRankingArr:)
    @NSManaged public func removeFromRankingArr(_ values: NSSet)

}
