//
//  TaxEntity+CoreDataProperties.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension TaxEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaxEntity> {
        return NSFetchRequest<TaxEntity>(entityName: "TaxEntity")
    }

    @NSManaged public var value: Double
    @NSManaged public var name: String?

}
