//
//  ProductEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var dateAdded: String?
    @NSManaged public var name: String?
    @NSManaged public var tax: TaxEntity?
    @NSManaged public var varients: NSSet?

}

// MARK: Generated accessors for varients
extension ProductEntity {

    @objc(addVarientsObject:)
    @NSManaged public func addToVarients(_ value: VarientEntity)

    @objc(removeVarientsObject:)
    @NSManaged public func removeFromVarients(_ value: VarientEntity)

    @objc(addVarients:)
    @NSManaged public func addToVarients(_ values: NSSet)

    @objc(removeVarients:)
    @NSManaged public func removeFromVarients(_ values: NSSet)

}
