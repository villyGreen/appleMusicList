//
//  AuthService.swift
//  musicListApp
//
//  Created by zz on 14.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import FirebaseAuth


class AuthService {
    
    static let shared = AuthService()
    var auth = Auth.auth()
    var verificationID: String?
    
    func register(email: String,password: String,completion: @escaping (Result<User,Error>) -> Void) {
        
        auth.createUser(withEmail: email,
                        password: password) { (result, error) in
                            if let result = result {
                                completion(.success(result.user))
                            } else {
                                completion(.failure(error!))
                            }
        }
    }
    
    
    func logIn(email: String,password: String,completion: @escaping (Result<User,Error>) -> Void){
        Auth.auth().signIn(withEmail: email,
                           password: password) { (result, error) in
                            if let result = result {
                                completion(.success(result.user))
                            } else {
                                completion(.failure(error!))
                            }
        }
    }
}
