//
//  StoreTabBarViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 06/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class StoreTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
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
        print(fromView.tag)
        print(toView.tag)
        return true
    }
}
