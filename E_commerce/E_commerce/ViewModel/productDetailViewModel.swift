//
//  productDetailViewModel.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation

struct ProductDetailViewModel {
    var product: ProductEntity?
    
    init(product: ProductEntity?) {
        self.product = product
    }
    
    var title: String {
        return product?.name ?? "Coming Soon.."
    }
    
    var totalVarient: Int{
        return product?.varients?.allObjects.count ?? 0
    }
    
    var variants: [VarientEntity]?{
        return product?.varients?.allObjects as? [VarientEntity]
    }
    
    func getCellViewModel(index: Int) -> ProductDetailCellViewModel?{
        return ProductDetailCellViewModel.init(variant: variants?[index], tax: product?.tax)
    }
    
}

struct ProductDetailCellViewModel {
    var variant: VarientEntity?
    var tax: TaxEntity?
    
    init(variant: VarientEntity?, tax: TaxEntity?) {
        self.variant = variant
        self.tax = tax
    }
    
    var size: String {
        return "Size: " + String(variant?.size ?? 0)
    }
    
    var priceLabelValue: String{
        return "Price: " + String(format: "%0.1f", getPrice())
    }
    
    func getPrice() -> Double{
        let taxvalue = ((Double(variant?.price ?? 0) * (tax?.value ?? 0.0)) / 100)
        let price: Double = Double(variant?.price ?? 0) + taxvalue
        return price
    }
    
    var color: String{
        return "Color: " + (variant?.color ?? "")
    }
}
