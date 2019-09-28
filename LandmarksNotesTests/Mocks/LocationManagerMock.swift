//
//  LocationManagerMock.swift
//  LandmarksNotesTests
//
//  Created by Andrew Yohanna on 27/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
import CoreLocation
@testable import LandmarksNotes

class LocationManagerMock: CLLocationManager {
    let mockLocation = CLLocation(coordinate: CLLocationCoordinate2D(latitude: -33.3, longitude: 150.0), altitude: 1.0, horizontalAccuracy: 0.5, verticalAccuracy: 0.5, course: 90.0, speed: 0, timestamp: Date())
    
    var isLocationRequested = false
    var isRequestWhenInUseAuthorizationCalled = false
    
    override func requestLocation() {
        isLocationRequested = true
        delegate?.locationManager?(self, didUpdateLocations: [mockLocation])
    }
    
    override func requestWhenInUseAuthorization() {
        isRequestWhenInUseAuthorizationCalled = true
    }
}
