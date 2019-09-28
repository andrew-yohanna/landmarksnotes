//
//  UserStore.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

protocol UserStoreProtocol {
    var userName: String { get }
    func login(with userName: String)
}

 class UserStore: UserStoreProtocol {
    static let shared = UserStore()
    var userName: String = ""
    
    // Handling login - For the sake of the challenge, it is a simple setting of the user name variable
    func login(with userName: String) {
        self.userName = userName
    }
}

