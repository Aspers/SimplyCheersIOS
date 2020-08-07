//
//  CategoryController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 07/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

class CategoryController {
    
    var baseURL = URL(string: "https://cheersappapi.azurewebsites.net/api")!
    var jsonDecoder = JSONDecoder()

    func fetchAllCategories(completion: @escaping ([Category]?) -> Void) {
        let categoryUrl = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryUrl) {
            (data, response, error) in
            print(categoryUrl)
            if let data = data, let categoryData = try? self.jsonDecoder.decode([Category].self, from: data) {
                completion(categoryData)
            } else {
                print("Failed to fetch categories")
                completion(nil)
                return
            }
        }

        task.resume()
    }
    
}
