//
//  BaseViewModel.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import Firebase

class BaseViewModel:  NSObject {
    let db = Firestore.firestore()
}
