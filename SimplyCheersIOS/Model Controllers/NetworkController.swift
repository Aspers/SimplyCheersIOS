//
//  NetworkController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

class NetworkController {
    
    var baseURL = URL(string: "https://cheersappapi.azurewebsites.net/api")!
    var jsonDecoder = JSONDecoder()

    func fetchAllProducts(completion: @escaping ([Product]?) -> Void) {
        let productUrl = baseURL.appendingPathComponent("products")
        let task = URLSession.shared.dataTask(with: productUrl) {
            (data, response, error) in
            if let data = data, let productData = try? self.jsonDecoder.decode([Product].self, from: data) {
                completion(productData)
            } else {
                print("Network request failed")
                completion(nil)
                return
            }
        }

        task.resume()
    }
    
    func fetchAllCategories(completion: @escaping ([Category]?) -> Void) {
        let categoryUrl = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryUrl) {
            (data, response, error) in
            print(categoryUrl)
            if let data = data, let categoryData = try? self.jsonDecoder.decode([Category].self, from: data) {
                completion(categoryData)
            } else {
                print("Network request failed")
                completion(nil)
                return
            }
        }

        task.resume()
    }
    
    func fetchAllActiveUsers(completion: @escaping ([User]?) -> Void) {
        let userUrl = baseURL.appendingPathComponent("users").appendingPathComponent("active")
        let task = URLSession.shared.dataTask(with: userUrl) {
            (data, response, error) in
            print(userUrl)
            if let data = data, let userData = try? self.jsonDecoder.decode([User].self, from: data) {
                completion(userData)
            } else {
                print("Network request failed")
                completion(nil)
                return
            }
        }

        task.resume()
    }
}
