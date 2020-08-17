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
    var sortProductEntity: [ProductEntity] = []
    
    init(productData: ProductDataEntity) {
        self.productData = productData
    }
    
    var categaoryCurrentIndex: Int = 0
    
    var categories: [CategoryEntity] {
        return (productData.categories?.allObjects as? [CategoryEntity]) ?? []
    }
    
    var isSortView: Bool = false
    var sortType: String = ""
    
    var categoryCount: Int{
        return isSortView ? 1 : categories.count
    }

    func getCategoryViewModel(index: Int) -> CategoryCellViewModel{
        return CategoryCellViewModel.init(category: categories[index])
    }
    
    func categoryTitle(index: Int) -> String{
        return isSortView ? sortType : getCategoryViewModel(index: index).title
    }
    
    mutating func getProductCellViewModel(section: Int, index: Int) -> ProductCellViewModel?{
        if isSortView{
            if sortProductEntity.count > 0{
                return ProductCellViewModel.init(product: sortProductEntity[index])
            }
        }
        else{
            if let products = getProductObj(section: section){
                if products.count > 0{
                    return ProductCellViewModel.init(product: products[index])
                }
            }
        }
        return nil
    }
    
    func getProductObj(section: Int) -> [ProductEntity]?{
        return isSortView ? sortProductEntity : (categories[section].products?.allObjects as? [ProductEntity])
    }
    
    mutating func setCategoryCurrentindex(index: Int){
        categaoryCurrentIndex = index
    }
    
    mutating func getProductDetailViewModel(section: Int, index: Int) -> ProductDetailViewModel?{
        if isSortView{
            if sortProductEntity.count > 0{
                return ProductDetailViewModel.init(product: sortProductEntity[index])
            }
        }
        else{
            if let products = getProductObj(section: section){
                if products.count > 0{
                    return ProductDetailViewModel.init(product: products[index])
                }
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
    
    mutating func getSortedProductData(productRankingVM: RankingViewModel?){
        guard var rankingArr = productRankingVM?.rankingArr else{
          return
        }
        sortProductEntity.removeAll()
        sortType = productRankingVM?.title ?? ""
        switch productRankingVM?.title{
        case "Most OrdeRed Products":
           rankingArr = rankingArr.sorted(by: { $0.orderCount > $1.orderCount })
        case "Most Viewed Products":
            rankingArr = rankingArr.sorted(by: { $0.viewCount > $1.viewCount })
        case "Most ShaRed Products":
            rankingArr = rankingArr.sorted(by: { $0.shares > $1.shares })
        default:
            break
        }
        
        isSortView = true
        for ranking in rankingArr{
            if let value = CoreDataManager.shared().fetchProductWith(id: ranking.id) as? ProductEntity{
                sortProductEntity.append(value)
            }
        }
    }
    
    mutating func removesortfilter(){
        isSortView = false
        sortProductEntity.removeAll()
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
