//
//  ViewController.swift
//  musicListApp
//
//  Created by zz on 09.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loadd!!!!")
        DataRequestService.shared.getData(searchText: "Nirvana")
        
    }
    @IBAction func registerAction(_ sender: UIButton) {
        let registerVc = RegisterViewController()
        transition(vc: registerVc)
    }
    @IBAction func inputAction(_ sender: UIButton) {
        let authVc = AuthViewController()
        self.present(authVc, animated: true, completion: nil)
    }
}
