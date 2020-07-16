//
//  UserDetailViewController.swift
//  ExpertLadr_SystemTask
//
//  Created by Harish Sami on 16/07/20.
//  Copyright © 2020 Harish Sami. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
@IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserDetails()

        // Do any additional setup after loading the view.
    }
    
    func showUserDetails() {
        guard let currentUserDetails = StorageService().getModel(entityName: "User").last else {
            preconditionFailure("Unable to find user details")
        }
        self.userNameLabel.text = "Welcome \(currentUserDetails.userName) & your pwd is \(currentUserDetails.password)"
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
