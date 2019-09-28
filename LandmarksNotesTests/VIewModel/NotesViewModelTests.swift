//
//  NotesViewModelTests.swift
//  LandmarksNotesTests
//
//  Created by Andrew Yohanna on 27/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import LandmarksNotes
import MapKit

class NotesViewModelTests: XCTestCase {
    var sut: NotesViewModel!
    let repoMock = LandmarksNotesRespositoryMock()
    let userStoreMock = UserStoreMock()
    let locationManagerMock = LocationManagerMock()
    
    var isOnNoteAddedCallbackCalled = false
    var isOnNotesFilteredCallbackCalled = false

    override func setUp() {
        super.setUp()
        sut = NotesViewModel(with: repoMock, userStore: userStoreMock, locationManager: locationManagerMock)
        sut.onNoteAdded = {
            self.isOnNoteAddedCallbackCalled = true
        }
        sut.onNotesFiltered = {
            self.isOnNotesFilteredCallbackCalled = true
        }
    }

    override func tearDown() {
        sut = nil
        isOnNoteAddedCallbackCalled = false
        isOnNotesFilteredCallbackCalled = false
        repoMock.isAddCalled = false
        repoMock.isSearchCalled = false
    }
    
    func testInitialState() {
        XCTAssertEqual(repoMock.landmarksNotes.count, 3)
        XCTAssertEqual(sut.notesToShow.count, 3)
        XCTAssertEqual(self.isOnNoteAddedCallbackCalled, false)
        XCTAssertEqual(self.isOnNotesFilteredCallbackCalled, false)
    }
    
    func testAddNote() {
        // When
        sut.add(note: "New Note")
        
        // Assert
        XCTAssert(locationManagerMock.isRequestWhenInUseAuthorizationCalled)
        XCTAssert(locationManagerMock.isLocationRequested)
        XCTAssert(repoMock.isAddCalled)
        XCTAssertNotNil(repoMock.landmarkNoteToBeAdded)
        
        if let landmarkNoteToBeAdded = repoMock.landmarkNoteToBeAdded {
            XCTAssertEqual(landmarkNoteToBeAdded.note, "New Note")
            XCTAssertEqual(landmarkNoteToBeAdded.location.longitude, locationManagerMock.mockLocation.coordinate.longitude)
            XCTAssertEqual(landmarkNoteToBeAdded.location.latitude, locationManagerMock.mockLocation.coordinate.latitude)
        }
        
        XCTAssertEqual(self.isOnNoteAddedCallbackCalled, true)
        XCTAssertEqual(sut.currentNoteToAdd, "")
    }
    
    func testFilteringWithEmptySearchText() {
        // When searching with empty text
        sut.filterContentForSearchText(" ")
        XCTAssertEqual(repoMock.isSearchCalled, false)

        XCTAssertEqual(sut.notesToShow.count, 3)
        XCTAssertEqual(self.isOnNotesFilteredCallbackCalled, true)
    }
    
    func testFilteringWithResults() {
        // When search text
        sut.filterContentForSearchText("dummySearchText")
        XCTAssertEqual(repoMock.isSearchCalled, true)
        XCTAssertEqual(sut.notesToShow.count, 1)
        XCTAssertEqual(self.isOnNotesFilteredCallbackCalled, true)
    }
}
