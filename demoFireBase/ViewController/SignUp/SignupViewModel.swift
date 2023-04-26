//
//  SignupViewModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import Firebase
 
class SignupViewModel: BaseViewModel {
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var city: String = ""
    var phone: String = ""
    
    func signupAuth(completionHandler: @escaping ((_ success: Bool, _ message: String)->())) {
        Auth.auth().createUser(withEmail: email, password: password)
        {
            authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode.Code(rawValue: error.code)
                {
                case .operationNotAllowed:
                    completionHandler(false, "operationNotAllowed")
                    DLog("operationNotAllowed")
                    break
                case .emailAlreadyInUse:
                    completionHandler(false, "emailAlreadyInUse")
                    DLog("emailAlreadyInUse")
                    break
                case .invalidEmail:
                    completionHandler(false, "invalidEmail")
                    DLog("invalidEmail")
                    break
                case .weakPassword:
                    completionHandler(false, "weakPassword")
                    DLog("weakPassword")
                    break
                default:
                    DLog("Error: \(error.localizedDescription)")
                    completionHandler(false, error.localizedDescription)
                    
                }
            }
            else {
                DLog("User signs up successfully")
                self.storeLoginData(completionHandler: completionHandler)
            }
        }
    }
    
    private func storeLoginData(completionHandler: @escaping ((_ success: Bool, _ message: String)-> ())) {
        var ref: DocumentReference? = nil
        ref = db.collection(FirestoreTableInfo.users).addDocument(data: [
            "name": name,
            "email": email,
            "city": city,
            "phone" : phone,
            "password": password
        ])
        {
            error in
            if let error = error {
                completionHandler(false, error.localizedDescription)
                DLog("Error adding document: \(error)")
                
            }else {
                completionHandler(true, "user Sign up successfully")
                DLog("Document added with ID : \(ref!.documentID)")
            }
        }
    }
}
