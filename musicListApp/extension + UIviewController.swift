//
//  extension + UIviewController.swift
//  musicListApp
//
//  Created by zz on 14.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


extension UIViewController {
    func showAlert(title: String?, message : String?, actionOne: String?, actionTwo: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionAddButton = UIAlertAction(title: actionOne, style: .default)
        let cancelButton = UIAlertAction(title: actionTwo, style: .destructive, handler: nil)
        alert.addAction(actionAddButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}
