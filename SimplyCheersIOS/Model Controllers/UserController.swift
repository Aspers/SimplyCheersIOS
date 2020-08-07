//
//  UserController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 07/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

class UserController {
    
    var baseURL = URL(string: "https://cheersappapi.azurewebsites.net/api")!
    var jsonDecoder = JSONDecoder()
    
    func fetchAllActiveUsers(completion: @escaping ([User]?) -> Void) {
        let userUrl = baseURL.appendingPathComponent("users").appendingPathComponent("active")
        let task = URLSession.shared.dataTask(with: userUrl) {
            (data, response, error) in
            print(userUrl)
            if let data = data, let userData = try? self.jsonDecoder.decode([User].self, from: data) {
                completion(userData)
            } else {
                print("Failed to fetch users")
                completion(nil)
                return
            }
        }

        task.resume()
    }
}
