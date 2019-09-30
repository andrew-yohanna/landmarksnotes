//
//  UIViewController+Toast.swift
//  LandmarksNotes
//
//  Created by Andrew Yohanna on 30/9/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

extension UIViewController {
    func showToast(message: String, seconds: Double = 2) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
