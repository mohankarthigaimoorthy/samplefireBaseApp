//
//  UpdateProfileViewModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation

class UpdateProfileViewModel: BaseViewModel {
    
    var userInfo: UserModel!
    
    func updateUserProfileDocument(completionHandler: @escaping ((_ success: Bool, _ message: String) -> ())) {
        
        let washingRef = db.collection(FirestoreTableInfo.users).document(userInfo.documentID)
        
        washingRef.updateData([
            "name": userInfo.name,
            "email": userInfo.email,
            "city": userInfo.city,
            "phone": userInfo.phone,
            "password": userInfo.password
        ])
        {
        err in
            if let err = err {
                completionHandler(false, err.localizedDescription)
                DLog("Error updating document: \(err)")
            }
            else {
                completionHandler(true, "Document successfully updated")
                DLog("Document successfully updated")
            }
            
        }
    }
}
