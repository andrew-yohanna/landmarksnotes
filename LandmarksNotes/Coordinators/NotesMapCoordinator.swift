//
//  NotesMapCoordinator.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 24/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class NotesMapCoordinator {
    var navigationController: UINavigationController
    var childViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Entry point to start the Map flow
    func start() {
        let mapStoryBoard = UIStoryboard(name: "Map", bundle: nil)
        if let vc = mapStoryBoard.instantiateViewController(withIdentifier: "Map") as? NotesMapViewController {
            vc.viewModel = NotesViewModel()
            vc.logout = logout
            navigationController.pushViewController(vc, animated: false)
            childViewController = vc
        }
    }
    
    // Handle calling UserLoginCoordinator to start UserLogin flow
    private func logout() {
        guard childViewController != nil else { return }
        let userLoginCoordinator = UserLoginCoordinator(parent: childViewController!)
        userLoginCoordinator.start()
    }
}
