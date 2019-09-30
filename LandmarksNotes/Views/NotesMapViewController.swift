//
//  MapViewController.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 24/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit
import MapKit

class NotesMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var buttonLoadingIndicator: UIActivityIndicatorView!
    
    var viewModel: NotesViewModel!
    var logout: (() -> Void)?

    fileprivate func setupMapView() {
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        populateMapAnnotations()
    }
    
    fileprivate func setupNotesTextField() {
        noteTextField.text = viewModel.currentNoteToAdd
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onNoteAdded = onNoteAdded
        viewModel.onErrorAddingNote = onErrorAddingNote
        viewModel.updateLocationLoadingStatus = updateLocationLoadingStatus
        setupMapView()
        setupNotesTextField()
        handleKeyboardToggling()
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }

    @IBAction func addNotePressed(_ sender: Any) {
        guard let note = noteTextField.text, !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return } // Show an error
        viewModel.add(note: note)
        noteTextField.resignFirstResponder()
    }
    
    @objc func logoutUser() {
        self.logout?()
    }
}

extension NotesMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "landmarkNoteAnnotation")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
}

extension NotesMapViewController {
    fileprivate func populateMapAnnotations() {
        let annotations = viewModel.landmarksNotes.map { annotationForLocation($0) }
        mapView.addAnnotations(annotations)
    }
    
    fileprivate func annotationForLocation(_ landmarkNote: LandmarkNote) -> MKAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "\(landmarkNote.userName)"
        annotation.subtitle = "\(landmarkNote.note)"
        annotation.coordinate = landmarkNote.location
        return annotation
    }
    
    func onNoteAdded() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.populateMapAnnotations()
            self.noteTextField.text = self.viewModel.currentNoteToAdd
            self.showToast(message: "Note added successfully")
        }
    }
    
    func updateLocationLoadingStatus(isLoadingLocation :Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if isLoadingLocation {
                self.buttonLoadingIndicator.startAnimating()
                self.addNoteButton.isEnabled = false
            } else {
                self.buttonLoadingIndicator.stopAnimating()
                self.addNoteButton.isEnabled = true
            }
        }
    }
    
    func onErrorAddingNote(with errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showToast(message: errorMessage)
        }
    }   
}
