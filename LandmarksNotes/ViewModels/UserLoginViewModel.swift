//
//  UserLoginViewModel.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

class UserLoginViewModel {
    let userStore: UserStoreProtocol
    var onUserAuthenticated: (() -> Void)?

    init(with userStore: UserStoreProtocol = UserStore.shared) {
        self.userStore = userStore
    }
    
    func login(with userName: String) {
        userStore.login(with: userName)
        self.onUserAuthenticated?()
    }
}
