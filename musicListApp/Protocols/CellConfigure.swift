//
//  CellConfigure.swift
//  musicListApp
//
//  Created by zz on 22.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import Foundation

protocol CellConfiguring {
    
    static var reuseID: String { get }
    func configure<U: Hashable>(value: U)
}
