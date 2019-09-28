//
//  LandmarksNotesRepository.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 24/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
import MapKit

protocol LandmarksNotesRepositoryProtocol {
    var landmarksNotes: [LandmarkNote] { get }
    func add(landmarkNote: LandmarkNote)
    func search(with text: String) -> [LandmarkNote]
}

class LandmarksNotesRepository: LandmarksNotesRepositoryProtocol {
    static let shared = LandmarksNotesRepository()
    
    var landmarksNotes: [LandmarkNote] = []
   
    func add(landmarkNote: LandmarkNote) {
        landmarksNotes.append(landmarkNote)
    }
    
    func search(with searchText: String) -> [LandmarkNote] {
        return landmarksNotes.filter {
            $0.note.lowercased().contains(searchText.lowercased())
                || $0.userName.lowercased().contains(searchText.lowercased())
        }
    }
}
