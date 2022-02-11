//
//  CustomView.swift
//  musicListApp
//
//  Created by zz on 11.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


class CustomView: UIView {
    
    init(label: UILabel, tf: UITextField) {
        super.init(frame: .zero)
        self.addSubview(label)
//        self.addSubview(tf)
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
//        tf.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
             label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//             self.bottomAnchor.constraint(equalTo: tf.bottomAnchor)
        ])
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
