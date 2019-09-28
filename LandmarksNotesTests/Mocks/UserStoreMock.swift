//
//  UserStoreMock.swift
//  LandmarksNotesTests
//
//  Created by Andrew Yohanna on 27/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
@testable import LandmarksNotes


class UserStoreMock: UserStoreProtocol {
    var userName = "User 1"
    var isLoginCalled = false
    var userNameToBeAdded = ""
    
    func login(with userName: String) {
        isLoginCalled = true
        userNameToBeAdded = userName
    }
}
