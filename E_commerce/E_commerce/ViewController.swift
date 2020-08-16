//
//  ViewController.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO Update Coredata Entity
        if let productEntity = CoreDataManager.shared().fetchRequest(entityName: "ProductDataEntity"){
            if productEntity.count > 0{
                print(productEntity)
            }
            else{
                CoreDataManager.shared().deleteEntity(entityName: "ProductDataEntity")
                NetworkManager().getProductData { (data) in
                    if let data = data{
                        CoreDataManager.shared().prepare(dataForSaving: data)
                    }
                }
            }
        }
        else{
            CoreDataManager.shared().deleteEntity(entityName: "ProductDataEntity")
            NetworkManager().getProductData { (data) in
                if let data = data{
                    CoreDataManager.shared().prepare(dataForSaving: data)
                }
            }
        }
    }


}

