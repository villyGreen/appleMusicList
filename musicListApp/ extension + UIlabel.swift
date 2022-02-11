//
//   extension + UIlabel.swift
//  musicListApp
//
//  Created by zz on 11.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//
import UIKit

extension UILabel {
    convenience init(textLabel: String, fontLabel: UIFont?, textAlpha: CGFloat, textColor:UIColor) {
        self.init()
        self.text = textLabel
        self.font = fontLabel
        self.tintColor = textColor
        self.alpha = textAlpha
//            self.translatesAutoresizingMaskIntoConstraints = false
      }
}
