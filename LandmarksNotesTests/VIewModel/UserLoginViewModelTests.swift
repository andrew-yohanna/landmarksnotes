//
//  UserLoginViewModelTests.swift
//  LandmarksNotesTests
//
//  Created by Andrew Yohanna on 28/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import LandmarksNotes
import MapKit

class UserLoginViewModelTests: XCTestCase {
    var sut: UserLoginViewModel!
    let userStoreMock = UserStoreMock()
    
    var isOnUserAuthenticatedCallbackCalled = false
    
    override func setUp() {
        super.setUp()
        sut = UserLoginViewModel(with: userStoreMock)
        sut.onUserAuthenticated = {
            self.isOnUserAuthenticatedCallbackCalled = true
        }
    }
    
    override func tearDown() {
        sut = nil
        isOnUserAuthenticatedCallbackCalled = false
    }
    
    func testInitialState() {
        XCTAssertEqual(userStoreMock.isLoginCalled, false)
        XCTAssertEqual(self.isOnUserAuthenticatedCallbackCalled, false)
        XCTAssertEqual(userStoreMock.userNameToBeAdded, "")
    }
    
    func testLogin() {
        // When
        sut.login(with: "User 1")
        
        // Assert
        XCTAssert(userStoreMock.isLoginCalled)
        XCTAssert(self.isOnUserAuthenticatedCallbackCalled)
        XCTAssertEqual(userStoreMock.userNameToBeAdded, "User 1")
    }
}
