//
//  DashBoardViewModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation

class DashBoardViewModel: BaseViewModel{
    var arrusers = [UserModel]()
    
    func getUsersCollection(completionnHandler: @escaping ((_ success: Bool, _ message: String)-> ())) {
        db.collection(FirestoreTableInfo.users).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print ("Error getting document: \(err)")
                completionnHandler(false, err.localizedDescription)
            }
            else {
                guard let userJson = querySnapshot?.documents else {
                    return
                    
                }
                self.arrusers.removeAll()
                for user in userJson {
                    let user = UserModel(json: user.data(), documentID: user.documentID)
                        self.arrusers.append(user)
            }
            completionnHandler(true, "get user successfully")
        }
        
        }
    }
}
