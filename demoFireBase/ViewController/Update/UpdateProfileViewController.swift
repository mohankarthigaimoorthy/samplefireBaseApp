//
//  UpdateProfileViewController.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import UIKit

class UpdateProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var city: UITextField!
    
    var userInfo: UserModel!
    let updateprofileVM = UpdateProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        email.text = userInfo.email
        password.text = userInfo.password
        name.text = userInfo.name
        city.text = userInfo.city
        phone.text = userInfo.phone
    }
    
    private func updateUserProfileDocument() {
        let info = UserModel()
        info.documentID = userInfo.documentID
        info.email = email.text ?? ""
        info.password = password.text ?? ""
        info.name = name.text ?? ""
        info.city = city.text ?? ""
        info.phone = phone.text ?? ""
        updateprofileVM.userInfo = info
        ShowLoaderOnView()
   updateprofileVM.updateUserProfileDocument{ (success, msg) in
            HideLoaderOnView()
            if success {
                self.alert(message: msg)
                NotificationCenter.default.post(Notification.init(name: Notification.Name("updateData")))
            }
       else {
           self.alert(message: msg)
       }
        }
    }
    
    
    @IBAction func UpdateProfileButton(_ sender: Any) {
        updateUserProfileDocument()
    }
}
