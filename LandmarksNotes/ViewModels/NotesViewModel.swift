//
//  NotesMapViewModel.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 24/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
import MapKit

class NotesViewModel: NSObject {
    
    let userStore: UserStoreProtocol
    let repository: LandmarksNotesRepositoryProtocol
    let locationManager: CLLocationManager
    
    var currentNoteToAdd: String = ""
    var landmarksNotes: [LandmarkNote] {
        return repository.landmarksNotes
    }
    
    var notesToShow: [LandmarkNote] {
        if isFiltering {
            return filteredNotes
        } else {
            return landmarksNotes
        }
    }
    
    fileprivate var filteredNotes = [LandmarkNote]()
    fileprivate var isFiltering = false
    
    var onNoteAdded: (() -> Void)?
    var onNotesFiltered: (() -> Void)?
    var onErrorAddingNote: ((String) -> Void)?
    var updateLocationLoadingStatus: ((Bool) -> Void)?

    init(with repository: LandmarksNotesRepositoryProtocol = LandmarksNotesRepository.shared,
         userStore: UserStoreProtocol = UserStore.shared,
         locationManager: CLLocationManager = CLLocationManager()) {
        self.repository = repository
        self.userStore = userStore
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
    }
    
    func add(note: String) {
        currentNoteToAdd = note
        locationManager.requestLocation()
        self.updateLocationLoadingStatus?(true)
    }
}

extension NotesViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.updateLocationLoadingStatus?(false)

        guard let location = locations.last else {
            // Show error
            return
        }
        self.repository.add(landmarkNote: LandmarkNote(userName: userStore.userName, note: currentNoteToAdd, location: location.coordinate, address: ""))
        
        // Clear note field
        currentNoteToAdd = ""
        
        self.onNoteAdded?()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.updateLocationLoadingStatus?(false)
        // TODO: Handle error types messages
        self.onErrorAddingNote?("Sorry, we couldn't obtain your location")
    }
}

extension NotesViewModel {
    func filterContentForSearchText(_ searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.isFiltering = false
            self.filteredNotes = []
        } else {
            self.isFiltering = true
            self.filteredNotes = repository.search(with: searchText)
        }
        onNotesFiltered?()
    }
}
