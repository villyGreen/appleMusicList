//
//  ValidateService.swift
//  musicListApp
//
//  Created by zz on 11.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import Foundation


class ValidateService {
    
    static let shared = ValidateService()
    
    func validate(searchString: String, mode : Int) -> Bool {
        
        var password = " "
        let regexPhone = #"^((\+7|7|8)+([0-9]){10})$"#
        let regexPassword = #"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"#
        let regexUserName = #"^[a-zA-Z][a-zA-Z0-9-_\.]{1,20}$"#
        if searchString == " " {
            return false
        }
        switch mode {
        case 1:
            return validateNumberPhone(pattern: regexPhone, search: searchString)
        case 2:
            password = searchString
             return validateNumberPhone(pattern: regexPassword, search: searchString)
        case 3:
            return validateNumberPhone(pattern: regexUserName, search: searchString)
        default:
            break
        }
        
        return false
    }
    // #"^([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}$"#
    func validateNumberPhone(pattern: String, search: String) -> Bool {
        let text = search
        var isFound = false
        do {
            let regex = try NSRegularExpression(pattern: pattern )
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            if !results.isEmpty {
               isFound = true
                print("hello")
            } else {
                isFound =  false
                print("world")
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            
        }
        return isFound
    }
    
func comparePassword(firstPassword: String, secondPassword: String) -> Bool {
        var compare = false
        if firstPassword == secondPassword {
            compare = true
        } else {
            compare = false
        }
        return compare
    }
    
}
