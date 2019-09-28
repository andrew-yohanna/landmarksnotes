//
//  LandmarksNotesRespoistoryMock.swift
//  LandmarksNotesTests
//
//  Created by Andrew Yohanna on 27/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
@testable import LandmarksNotes
import MapKit

class LandmarksNotesRespositoryMock: LandmarksNotesRepositoryProtocol {
    var landmarksNotes = [LandmarkNote(userName: "User1", note: "ShortNote1", location: CLLocationCoordinate2D(latitude: -33.3, longitude: 150.000), address: ""),
                     LandmarkNote(userName: "User2", note: "SomeNotes2", location: CLLocationCoordinate2D(latitude: -33.4, longitude: 151.000), address: ""),
                     LandmarkNote(userName: "User2", note: "SomeNotes3", location: CLLocationCoordinate2D(latitude: -33.5, longitude: 152.000), address: "")]
    var isAddCalled = false
    var isSearchCalled = false

    var searchText = ""
    var landmarkNoteToBeAdded: LandmarkNote? = nil

    func add(landmarkNote: LandmarkNote) {
        self.isAddCalled = true
        self.landmarkNoteToBeAdded = landmarkNote
    }
    
    func search(with searchText: String) -> [LandmarkNote] {
        self.isSearchCalled = true
        self.searchText = searchText
        return [LandmarkNote(userName: "User1", note: "ShortNote1", location: CLLocationCoordinate2D(latitude: -33.3, longitude: 150.000), address: "")]
    }
}
