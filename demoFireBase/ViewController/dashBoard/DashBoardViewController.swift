//
//  DashBoardViewController.swift
//  demoFireBase
//
//  Created by Mohan K on 12/04/23.
//

import Foundation
import UIKit
import Firebase

class DashBoardViewController: BaseViewController {
    
    @IBOutlet weak var tableUsers: UITableView!
    let dashBoardViewModel = DashBoardViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(getusersCollection), name: NSNotification.Name("updateData"), object: nil)
    }
    
    private func setupUI() {
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        let buttonLogout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = buttonLogout
        setupTableView()
        getusersCollection()
    }
    
    @objc private func getusersCollection() {
        ShowLoaderOnView()
        dashBoardViewModel.getUsersCollection { (success, msg) in
            HideLoaderOnView()
            DispatchQueue.main.async {
                if success {
                    self.tableUsers.reloadData()
                }
                else {
                    self.alert(message: msg)
                }
            }
        }
    }
    
    private func setupTableView() {
        tableUsers.delegate = self
        tableUsers.dataSource = self
        tableUsers.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: "UsersCell")
    }
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
            DLog("Sign in Successfully")
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch {
            DLog("Sign out error")
        }
    }
}

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dashBoardViewModel.arrusers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell") as? UsersCell else {return UITableViewCell()}
        cell.emailLabel.text = dashBoardViewModel.arrusers[indexPath.row].email
        cell.nameLabel.text = dashBoardViewModel.arrusers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProfileViewController") as? UpdateProfileViewController
        vc?.userInfo = dashBoardViewModel.arrusers[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
