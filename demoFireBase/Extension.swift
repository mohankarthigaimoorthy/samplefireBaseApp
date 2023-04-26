//
//  Extension.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true,completion: nil)
    }
}
