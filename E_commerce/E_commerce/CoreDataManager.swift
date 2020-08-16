//
//  CoreDataManager.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject{
    
    private override init() {
        super.init()
        
        applicationLibraryDirectory()
    }
    // Create a shared Instance
    static let _shared = CoreDataManager()
    
    // Shared Function
    class func shared() -> CoreDataManager{
        return _shared
    }
    
    // Get the location where the core data DB is stored
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()
    
    private func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    // MARK: - Core Data stack
    
    // Get the managed Object Context
    lazy var managedObjectContext = {
        
        return self.persistentContainer.viewContext
    }()
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "E_commerce")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func prepare(dataForSaving: ProductData){
        let productDataEntity = ProductDataEntity(context: self.managedObjectContext)
        //let obj = dataForSaving.categories.map{self.createCategoryEntityFrom(category: $0)}
        
        guard let categories = dataForSaving.categories, let rankings = dataForSaving.rankings else {
            return
        }
        for category in categories{
            if let obj = self.createCategoryEntityFrom(category: category){
                productDataEntity.categories?.adding(obj)
            }
        }
        
        for ranking in rankings{
            if let obj = self.createRankingEntityFrom(ranking: ranking)
            {
                productDataEntity.ranking?.adding(obj)
            }
        }
        saveData()
    }
    
    private func createRankingEntityFrom(ranking: ProductRanking?) -> RankingEntity?{
        guard let ranking = ranking else {
            return nil
        }
        let rankingEntity = RankingEntity(context: self.managedObjectContext)
        rankingEntity.rankingType = ranking.ranking
        if let products = ranking.products {
            for ranking in products{
                if let obj = self.createProductRankingEntityFrom(productRanking: ranking)
                {
                    rankingEntity.rankingArr?.adding(obj)
                }
            }
        }
        return rankingEntity
    }
    
    private func createProductRankingEntityFrom(productRanking: Ranking?) -> ProductRankingEntity?{
        guard let productRanking = productRanking else {
            return nil
        }
        let productRankingEntity = ProductRankingEntity(context: self.managedObjectContext)
        productRankingEntity.id = productRanking.id
        productRankingEntity.viewCount = productRanking.viewCount
        productRankingEntity.shares = productRanking.shares
        productRankingEntity.orderCount = productRanking.orderCount
        return productRankingEntity
    }
    

    private func createCategoryEntityFrom(category: ProductCategory?) -> CategoryEntity?{
        guard let category = category else {
            return nil
        }
        let categoryEntity = CategoryEntity(context: self.managedObjectContext)
        categoryEntity.id = category.id
        categoryEntity.name = category.name
        if let products = category.products{
            for product in products{
                if let obj = self.createProductEntityFrom(product: product)
                {
                    categoryEntity.products?.adding(obj)
                }
            }
        }
        return categoryEntity
    }
    
    private func createProductEntityFrom(product: Product?) -> ProductEntity?{
        guard let product = product else {
            return nil
        }
        let productEntity = ProductEntity(context: self.managedObjectContext)
        productEntity.id = product.id
        productEntity.name = product.name
        productEntity.dateAdded = product.dateAdded
        productEntity.tax = self.createTaxEntityFrom(tax: product.tax)
        if let variants = product.variants {
            for variant in variants{
                if let obj = self.createVarientEntityFrom(varient: variant)
                {
                    productEntity.varients?.adding(obj)
                }
            }
        }
        return productEntity
    }
    
    private func createVarientEntityFrom(varient: Varient?) -> VarientEntity?{
        guard let varient = varient else {
            return nil
        }
        let varientEntity = VarientEntity(context: self.managedObjectContext)
        varientEntity.price = varient.price
        varientEntity.id = varient.id
        varientEntity.color = varient.color
        varientEntity.size = varient.size
        
        return varientEntity
    }
    
    private func createTaxEntityFrom(tax: Tax?) -> TaxEntity?{
        guard let tax = tax else {
            return nil
        }
        let taxEntity = TaxEntity(context: self.managedObjectContext)
        taxEntity.name = tax.name
        taxEntity.value = tax.value
        return taxEntity
    }

    // Save the data in Database
    func saveData(){
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // Save Data in background
//    func saveDataInBackground() {
//
//        persistentContainer.performBackgroundTask { (context) in
//
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
//    }
    
    func fetchRequest(entityName: String) -> [ProductDataEntity]?{
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
         
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
         
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
         
        do {
            let result = try self.managedObjectContext.fetch(fetchRequest) as? [ProductDataEntity]
            return result
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    func deleteEntity(entityName: String){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
         
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
         
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
         
        do {
            if let result = try self.managedObjectContext.fetch(fetchRequest) as? [ProductDataEntity]{
                for obj in result{
                    self.managedObjectContext.delete(obj)
                }
            }
            saveData()
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

}
