//
//  LoginFormController.swift
//  VKClient
//
//  Created by Lev on 2/22/21.
//

import UIKit

class LoginFormController: UIViewController {

    private let login = "admin",
                password = "password"
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        if loginField.text == login && passwordField.text == password {
            print("Logged in")
        } else {
            print("Wrong login or password")
        }
    }
}
