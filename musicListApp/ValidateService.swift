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
        
        let mailPattern = #"^[-\w.]+@([A-z0-9][-A-z0-9]+\.)+[A-z]{2,4}$"#
        let regexPhone = #"^((\+7|7|8)+([0-9]){10})$"#
        let regexPassword = #"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"#
        let regexUserName = #"^[a-zA-Z][a-zA-Z0-9-_\.]{1,20}$"#
        if searchString == " "  {
            return false
        }
        switch mode {
        case 0:
            return validateRegExspression(pattern: mailPattern, search: searchString)
        case 1:
            return validateRegExspression(pattern: regexPhone, search: searchString)
        case 2:
            return validateRegExspression(pattern: regexPassword, search: searchString)
        case 3:
            return validateRegExspression(pattern: regexUserName, search: searchString)
        default:
            break
        }
        
        return false
    }
    
    func validateRegExspression(pattern: String, search: String) -> Bool {
        let text = search
        var isFound = false
        do {
            let regex = try NSRegularExpression(pattern: pattern )
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            if !results.isEmpty {
                isFound = true
            } else {
                isFound =  false
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
