//
//  UserLoginCoordinator.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class UserLoginCoordinator {
    var parent: UIViewController
    
    init(parent: UIViewController) {
        self.parent = parent
    }
    
    // Entry point to start UserLogin flow
    func start() {
        let userLoginStoryBoard = UIStoryboard(name: "UserLogin", bundle: nil)
        if let vc = userLoginStoryBoard.instantiateViewController(withIdentifier: "UserLogin") as? UserLoginViewController {
            vc.viewModel = UserLoginViewModel()
            vc.onUserAuthenticated = userLoggedIn
            vc.modalPresentationStyle = .fullScreen
            parent.present(vc, animated: true)
        }
    }
    
    func userLoggedIn() {
        parent.dismiss(animated: true)
    }
}
