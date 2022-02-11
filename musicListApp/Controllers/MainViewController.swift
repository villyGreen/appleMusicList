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
    }

@IBAction func registerAction(_ sender: UIButton) {
        let registerVc = RegisterViewController()
        registerVc.modalPresentationStyle = .fullScreen
        self.present(registerVc, animated: true, completion: nil)
    }
    @IBAction func inputAction(_ sender: UIButton) {
    }
}
