//
//  ProductController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 07/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation
import UIKit

class ProductController {
    
    static let shared = ProductController()
    var baseURL = URL(string: "https://cheersappapi.azurewebsites.net/api")!
    var jsonDecoder = JSONDecoder()
    
    func fetchAllProducts(completion: @escaping ([Product]?) -> Void) {
        let productUrl = baseURL.appendingPathComponent("products")
        let task = URLSession.shared.dataTask(with: productUrl) {
            (data, response, error) in
            if let data = data, let productData = try? self.jsonDecoder.decode([Product].self, from: data) {
                completion(productData)
            } else {
                print("Failed to fetch products")
                completion(nil)
                return
            }
        }

        task.resume()
    }
    
    func fetchProductImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data, let image = UIImage(data:data) {
                completion(image)
            } else {
                print("Failed to fetch product image")
                completion(UIImage(named: "drink"))
            }
        }
        task.resume()
    }
    
}
