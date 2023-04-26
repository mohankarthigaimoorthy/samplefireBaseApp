//
//  SignupViewController.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import UIKit

class SignupViewController: BaseViewController {
    
    @IBOutlet weak var nametextField : UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var phonetextField: UITextField!
    @IBOutlet weak var citytextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var hide: UIButton!
    private let signupVM = SignupViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func signupAuth() {
        signupVM.email = emailtextField.text ?? ""
        signupVM.password = passwordtextField.text ?? ""
        signupVM.name = nametextField.text ?? ""
        signupVM.city = citytextField.text ?? ""
        signupVM.phone = phonetextField.text ?? ""
        
        ShowLoaderOnView()
        signupVM.signupAuth {
            (success, msg) in HideLoaderOnView()
            if success {
                self.alert(message: msg)
                
            }
            else {
                self.alert(message: msg)
            }
        }
    }
    @IBAction func signupButton(_ sender: UIButton) {
        signupAuth()
    }
    
    @IBAction func unHide(_ sender: UIButton) {
        
        if  sender.isSelected {
            passwordtextField.isSecureTextEntry = false
        } else {
          
            passwordtextField.isSecureTextEntry = true
    }
    
    sender.isSelected = !sender.isSelected
    }
}
