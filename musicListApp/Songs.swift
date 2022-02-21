//
//  Songs.swift
//  musicListApp
//
//  Created by zz on 22.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import Foundation



struct Song : Hashable, Decodable {
    var image: String
    var nameOfSong: String
    var nameOfCreator: String
    var timeOfSong: String
    var id: String
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
    
       static func == (lhs: Song,rhs: Song) -> Bool {
           return lhs.id == rhs.id
       }
       
       func contains(searchText: String?) -> Bool {
           guard let searchText = searchText else {
               return true
           }
           if searchText.isEmpty {
               return true
           }
           let capitalizedText = searchText.capitalized
           
           return nameOfSong.capitalized.contains(capitalizedText)
       }
}
