//
//  NetworkManager.swift
//  E_commerce
//
//  Created by Abhishek Mishra on 15/08/20.
//  Copyright © 2020 Abhishek Mishra. All rights reserved.
//

import Foundation
import CoreData

class NetworkManager {
    
    func getProductData(onCompletion: @escaping (_ data: ProductData?) -> Void){
        guard let url = URL(string: "https://stark-spire-93433.herokuapp.com/json") else { print("Incorrect URL"); return }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            do{
                if let data = data{
                    //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    //print("✅ json: \n\(json)")
                    let objectResponse = try JSONDecoder().decode(ProductData.self, from: data)
                    DispatchQueue.main.async {
                        onCompletion(objectResponse)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        onCompletion(nil)
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    onCompletion(nil)
                }
            }
        })
        task.resume()
    }
    
    
}
