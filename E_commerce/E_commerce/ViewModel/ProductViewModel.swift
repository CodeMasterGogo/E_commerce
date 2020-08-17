//
//  ProductViewModel.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 16/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation

struct ProductViewModel {
    
    var productData: ProductDataEntity
    
    init(productData: ProductDataEntity) {
        self.productData = productData
    }
    
    var categaoryCurrentIndex: Int = 0
    
    var categories: [CategoryEntity] {
        return (productData.categories?.allObjects as? [CategoryEntity]) ?? []
    }
    
    var isSortView: Bool = false
    
    var categoryCount: Int{
        return categories.count
    }

    func getCategoryViewModel(index: Int) -> CategoryCellViewModel{
        return CategoryCellViewModel.init(category: categories[index])
    }
    
    mutating func getProductCellViewModel(section: Int, index: Int) -> ProductCellViewModel?{
        if let products = getProductObj(section: section){
            if products.count > 0{
                return ProductCellViewModel.init(product: products[index])
            }
        }
        return nil
    }
    
    func getProductObj(section: Int) -> [ProductEntity]?{
        return (categories[section].products?.allObjects as? [ProductEntity])
    }
    
    mutating func setCategoryCurrentindex(index: Int){
        categaoryCurrentIndex = index
    }
    
    mutating func getProductDetailViewModel(section: Int, index: Int) -> ProductDetailViewModel?{
        if let products = getProductObj(section: section){
            if products.count > 0{
                return ProductDetailViewModel.init(product: products[index])
            }
        }
        return nil
    }
    
    func getSortViewModel() -> ProductSortViewModel?{
        if let obj = productData.ranking?.allObjects as? [RankingEntity]{
            return ProductSortViewModel.init(rankings: obj)
        }
        return nil
    }
}

struct CategoryCellViewModel {
    var category: CategoryEntity
    
    init(category: CategoryEntity) {
        self.category = category
    }
    
    var title: String{
        return category.name ?? ""
    }
}

struct ProductCellViewModel {
    var product: ProductEntity
    
    init(product: ProductEntity) {
        self.product = product
    }
    
    var title: String {
        return product.name ?? ""
    }
}
