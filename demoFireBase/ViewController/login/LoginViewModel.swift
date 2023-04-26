//
//  LoginViewModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import Firebase

class LoginViewModel : BaseViewModel {
  
    var email: String = ""
    var password: String = ""
    
    func loginAuth(completionHandeler: @escaping ((_ success: Bool, _ message: String) ->())) {
        Auth.auth().signIn(withEmail: email, password: password){
        (authResult, error) in
            HideLoaderOnView()
            if let error = error as NSError? {
                switch AuthErrorCode.Code(rawValue: error.code) {
                    
                case .operationNotAllowed:
                    DLog("operationNotAllowed")
                    completionHandeler(false, "operationNotAllowed")
                    break
                    
                case .userDisabled:
                    DLog("userDisabled")
                    completionHandeler(false, "userDisabled")
                    break
                    
                case .wrongPassword:
                    DLog("wrongPassword")
                    completionHandeler(false, "wrongPassword")
                    break
                    
                case .invalidEmail:
                    DLog("invalidEmail")
                    completionHandeler(false,"invalidEmail")
                    break
                    
                default:
                    completionHandeler(false, "invalidEmail")
                    DLog("Error: \(error.localizedDescription)")
                    
                }
            }
                else {
                    DLog("User Login SuccessFully")
                    completionHandeler(true,"user Login SucccessFully")
                }
                
            }
       }
    }
    

