//
//  ProductDataModel.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation

class ProductData: NSObject, Decodable{
    var categories: [ProductCategory]?
    var rankings: [ProductRanking]?
    
    enum CodingKeys: String, CodingKey {
        case rankings, categories
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            if let rankings = try container.decodeIfPresent([ProductRanking].self, forKey: .rankings){
                self.rankings = rankings
            }
            if let categories = try container.decodeIfPresent([ProductCategory].self, forKey: .categories){
                self.categories = categories
            }
        }catch {
            print(error)
        }
    }
    
}

class ProductCategory: NSObject, Decodable {
    var id: Int64 = 0
    var name: String = ""
    var products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case products, id, name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            if let id = try container.decodeIfPresent(Int64.self, forKey: .id){
                self.id = id
            }
            if let name = try container.decodeIfPresent(String.self, forKey: .name){
                self.name = name
            }
            if let products = try container.decodeIfPresent([Product].self, forKey: .products){
                self.products = products
            }
        }catch {
            print(error)
        }
    }
}

class Product: NSObject, Decodable {
    var id: Int64 = 0
    var name: String = ""
    var dateAdded: String = ""
    var variants: [Varient]?
    var tax: Tax?
    
    enum CodingKeys: String, CodingKey {
        case dateAdded = "date_added", variants, tax, id, name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            if let variants = try container.decodeIfPresent([Varient].self, forKey: .variants){
                self.variants = variants
            }
            if let name = try container.decodeIfPresent(String.self, forKey: .name){
                self.name = name
            }
            if let id = try container.decodeIfPresent(Int64.self, forKey: .id){
                self.id = id
            }
            if let tax = try container.decodeIfPresent(Tax.self, forKey: .tax){
                self.tax = tax
            }
            if let dateAdded = try container.decodeIfPresent(String.self, forKey: .dateAdded){
                self.dateAdded = dateAdded
            }

        }catch {
            print(error)
        }
    }
    
}

class Varient: NSObject, Decodable {
    var id: Int64 = 0
    var color: String = ""
    var size: Int16 = 0
    var price: Int64 = 0
    
    enum CodingKeys: String, CodingKey {
        case id, color, size, price
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            if let color = try container.decodeIfPresent(String.self, forKey: .color){
                self.color = color
            }
            if let id = try container.decodeIfPresent(Int64.self, forKey: .id){
                self.id = id
            }
            if let size = try container.decodeIfPresent(Int16.self, forKey: .size){
                self.size = size
            }
            if let price = try container.decodeIfPresent(Int64.self, forKey: .price){
                self.price = price
            }
            
        }catch {
            print(error)
        }
    }
}

class Tax: NSObject, Decodable {
    var name: String = ""
    var value: Double = 0.0
}

class ProductRanking: NSObject, Decodable {
    var ranking: String = ""
    var products: [Ranking]?
    
    enum CodingKeys: String, CodingKey {
           case ranking, products
       }

    required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           do{
               if let ranking = try container.decodeIfPresent(String.self, forKey: .ranking){
                   self.ranking = ranking
               }
               if let products = try container.decodeIfPresent([Ranking].self, forKey: .products){
                   self.products = products
               }
           }catch {
               print(error)
           }
       }
}

class Ranking: NSObject, Decodable {
    var id: Int64 = 0
    var viewCount: Int64 = 0
    var orderCount: Int64 = 0
    var shares: Int64 = 0
    
    enum CodingKeys: String, CodingKey {
        case viewCount = "view_count", id, orderCount = "order_count", shares
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            if let viewCount = try container.decodeIfPresent(Int64.self, forKey: .viewCount){
                self.viewCount = viewCount
            }
            if let orderCount = try container.decodeIfPresent(Int64.self, forKey: .orderCount){
                self.orderCount = orderCount
            }
            if let shares = try container.decodeIfPresent(Int64.self, forKey: .shares){
                self.shares = shares
            }
            if let id = try container.decodeIfPresent(Int64.self, forKey: .id){
                self.id = id
            }
        }catch {
            print(error)
        }
    }
}
