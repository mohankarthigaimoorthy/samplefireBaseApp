//
//  UserModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation

class UserModel {
    
    var documentID = ""
    var name = ""
    var email = ""
    var password = ""
    var phone = ""
    var city = ""
    
    init() {
    }
    
    init(json: [String: Any], documentID: String = "") {
        self.documentID = documentID
        name = json["name"] as? String ?? ""
        email = json["email"] as? String ?? ""
        password = json["password"] as? String ?? ""
        phone = json["phone"] as? String ?? ""
        city = json["city"] as? String ?? ""
    }
}
