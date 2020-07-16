//
//  ViewController.swift
//  ExpertLadr_SystemTask
//
//  Created by Harish Sami on 16/07/20.
//  Copyright © 2020 Harish Sami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    let storageService = StorageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func loginButton(_ sender: Any) {
        self.view.endEditing(true)
        if userName.text?.isEmpty == false, password.text?.isEmpty == false {
            if storageService.saveUserDetails(userName: userName.text ?? "", password: password.text ?? "") {
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

}

