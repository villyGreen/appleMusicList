//
//  DataRequestService.swift
//  musicListApp
//
//  Created by zz on 23.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import Alamofire

class DataRequestService {
    static let shared = DataRequestService()
    func getData(searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)"
        guard let url = URL(string: urlString) else { return }
        AF.request(url).responseData { (data) in
            guard data.error == nil else { return }
            guard let dataString = data.data else { return }
            let stringData = String(data: dataString, encoding: .utf8)
            print(stringData)
        }
    }
}

