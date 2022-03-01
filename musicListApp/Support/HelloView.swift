//
//  HelloView.swift
//  musicListApp
//
//  Created by zz on 01.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


class HelloView: UIView {
        let image = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "helloImage")
        image.contentMode = .scaleAspectFill
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
