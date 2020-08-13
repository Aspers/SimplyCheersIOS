//
//  StoreTabBarViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 06/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class StoreTabBarViewController: UITabBarController {
    
    var cartTabBarItem: UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateCartBadge), name: CartController.cartItemsUpdatedNotification, object: nil)
        cartTabBarItem = viewControllers?[2].tabBarItem
        delegate = self
    }
    
    @objc func updateCartBadge() {
        DispatchQueue.main.async {
            if CartController.shared.cart.totalItems == 0 {
                self.cartTabBarItem.badgeValue = nil
            } else {
                self.cartTabBarItem.badgeValue = String(CartController.shared.cart.totalItems)
            }
        }
    }
}

extension StoreTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}
