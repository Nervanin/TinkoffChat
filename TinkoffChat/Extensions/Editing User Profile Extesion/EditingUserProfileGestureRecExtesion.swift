//
//  EditinUserProfileGestureRecExtesion.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

// MARK: Logic for tap and long press on user image
// extention for user image. Here add TapGesture for user image
extension EditingUserProfileViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === longPressGestureRecognizer
    }
    
    @objc func imageLongPressed(tapGestureRecognizer: UILongPressGestureRecognizer) {
        chooseSourceForImageAlert()
    }
    
    @objc func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if setUserImage.image != UIImage(named: "placeholder-user") {
            let zoomUserImageViewController = ZoomUserImageViewController()
            zoomUserImageViewController.userImage.image = self.setUserImage.image
            present(zoomUserImageViewController, animated: true, completion: nil)
        }
    }
    
}



