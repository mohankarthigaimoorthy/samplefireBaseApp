//
//  LoginViewController.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import UIKit

class LoginViewController : BaseViewController {
    
    
    @IBOutlet weak var emailtextField : UITextField!
    @IBOutlet weak var passwordtextField : UITextField!
    @IBOutlet weak var eyeicon: UIButton!
    
    private let loginVm = LoginViewModel()
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Application.isInDevlopment {
            emailtextField.text = ""
            passwordtextField.text = ""
        }
    }
    
    private func loginAuth() {
        ShowLoaderOnView()
        loginVm.email = emailtextField.text ?? ""
        loginVm.password = passwordtextField.text ?? ""
        loginVm.loginAuth { (success, msg) in
            HideLoaderOnView()
            if success {
                self.gotoDashboard()
            }else {
                self.alert(message: msg)
            }
        }
    }
    
    private func gotoDashboard() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashBoardViewController")
        as? DashBoardViewController
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    @IBAction func  LoginButton(_ sender: Any) {
   loginAuth()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func iconAction(sender: UIButton) {
        if  sender.isSelected {
            passwordtextField.isSecureTextEntry = false
//            eyeicon.setImage(UIImage(named: "eye"), for: .normal)

        } else {
          
            passwordtextField.isSecureTextEntry = true
//            eyeicon.setImage(UIImage(named: "eye.slash.fill"), for: .normal)
        }
        sender.isSelected = !sender.isSelected
//        iconClick = !iconClick
    }
}
