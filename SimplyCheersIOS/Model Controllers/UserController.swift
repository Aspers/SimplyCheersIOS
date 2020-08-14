//
//  UserController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 07/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    var baseURL = URL(string: "https://cheersappapi.azurewebsites.net/api")!
    var jsonDecoder = JSONDecoder()
    
    static let selectedUserUpdatedNotification = Notification.Name("UserController.selectedUserUpdated")
    var selectedUser: User! = nil {
        didSet {
            NotificationCenter.default.post(name: UserController.selectedUserUpdatedNotification, object: nil)
        }
    }
    
    
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
    
    func updateUserBalance(forAmount amount: Decimal, completion: @escaping (Bool) -> Void) {
        let updateUrl = baseURL.appendingPathComponent("users/\(selectedUser.userId)")
        var request = URLRequest(url: updateUrl)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newBalance = selectedUser.balance - amount
        let data = UserDTO(userId: selectedUser.userId, balance: newBalance)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                completion(httpResponse.statusCode == 200)
            } else {
                completion(false)
            }
        }
        task.resume()
        
    }
    
    func clearSelectedUser() {
        DispatchQueue.main.async {
            self.selectedUser = nil
        }
    }
}
