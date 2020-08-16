//
//  VarientEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension VarientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VarientEntity> {
        return NSFetchRequest<VarientEntity>(entityName: "VarientEntity")
    }

    @NSManaged public var price: Int64
    @NSManaged public var size: Int16
    @NSManaged public var color: String?
    @NSManaged public var id: Int64

}
