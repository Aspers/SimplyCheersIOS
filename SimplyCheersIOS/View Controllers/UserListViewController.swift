//
//  UserViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    let networkController = NetworkController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //networkController.fetchAllCategories()
        //networkController.fetchAllProducts()
        
//        networkController.fetchAllActiveUsers {
//            (users) in
//            guard let users = users else { return }
//            print(users)
//        }
        networkController.fetchAllProducts {
            (products) in
            guard let products = products else { return }
            print(products)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
