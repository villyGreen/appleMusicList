//
//  TabBarController.swift
//  musicListApp
//
//  Created by zz on 14.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            viewControllers = [
                setupVc(VC: SearchViewController(), title: "Search", image: UIImage(named: "Search")!),
                setupVc(VC: ListViewController(), title: "Music", image: UIImage(named: "Browse")!)
            ]
        } else {
            // Fallback on earlier versions
        }
    }
   
    
    private func setupVc(VC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVc = UINavigationController(rootViewController: VC)
        navigationVc.tabBarItem.image = image
        navigationVc.tabBarItem.title = title
        navigationVc.title = title
        navigationVc.navigationBar.prefersLargeTitles = true
        return navigationVc
    }

}
