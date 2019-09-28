//
//  UserLoginViewController.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    
    var viewModel: UserLoginViewModel!
    var onUserAuthenticated: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        handleKeyboardToggling()
        viewModel.onUserAuthenticated = onUserAuthenticated
    }
    
    @IBAction func login(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return } // Show an error
        userNameTextField.resignFirstResponder()
        viewModel.login(with: userName)
    }
}
