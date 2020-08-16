//
//  ProductRankingEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductRankingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductRankingEntity> {
        return NSFetchRequest<ProductRankingEntity>(entityName: "ProductRankingEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var orderCount: Int64
    @NSManaged public var shares: Int64
    @NSManaged public var viewCount: Int64

}
