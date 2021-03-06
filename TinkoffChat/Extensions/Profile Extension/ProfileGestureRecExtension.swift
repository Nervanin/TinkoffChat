//
//  ProfileGestureRecExtention.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

// MARK: Logic for tap and long press on user image
// extention for user image. Here add TapGesture for user image
extension ProfileViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === longPressGestureRecognizer
    }
    
    @objc func imageLongPressed(tapGestureRecognizer: UILongPressGestureRecognizer) {
    }
    
    @objc func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if userImage.image != UIImage(named: "placeholder-user") {
            let zoomUserImageViewController = ZoomUserImageViewController()
            zoomUserImageViewController.userImage.image = self.userImage.image
            present(zoomUserImageViewController, animated: true, completion: nil)
        }
    }
    
}
