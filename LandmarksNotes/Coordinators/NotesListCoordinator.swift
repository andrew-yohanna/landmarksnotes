//
//  NotesListCoordinator.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 26/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class NotesListCoordinator {
    var navigationController: UINavigationController
    var childViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Entry point to start the List flow
    func start() {
        let notesListStoryBoard = UIStoryboard(name: "NotesList", bundle: nil)
        if let vc = notesListStoryBoard.instantiateViewController(withIdentifier: "NotesList") as? NotesListTableViewController {
            vc.viewModel = NotesViewModel()
            vc.logout = logout
            navigationController.pushViewController(vc, animated: false)
            childViewController = vc
        }
    }
    
    private func logout() {
        guard childViewController != nil else { return }
        let userLoginCoordinator = UserLoginCoordinator(parent: childViewController!)
        userLoginCoordinator.start()
    }
}
