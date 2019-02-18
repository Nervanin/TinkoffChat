//
//  G.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

// MAKR: gestureRecognizerFunctions protocol
//protocol for extension Profile and EditingUserProfile VC. via him we cah choose image by photo libriarry or camera by long press on image or we can Zoom image by one tap
protocol GestureRecognizerLogicForUserProfileImage {
    var userImage: UIImageView! { get set }
    var imagePicker: UIImagePickerController { get set }
    var singleTapGestureRecognizer: UITapGestureRecognizer { get set }
    var longPressGestureRecognizer: UILongPressGestureRecognizer { get set }
    func setUpGestureRecognizer()
    func chooseSourceForImageAlert()
    func imageLongPressed(tapGestureRecognizer: UILongPressGestureRecognizer)
    func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
}


extension GestureRecognizerLogicForUserProfileImage {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === longPressGestureRecognizer
    }
    
    func imageLongPressed(tapGestureRecognizer: UILongPressGestureRecognizer) {
        chooseSourceForImageAlert()
    }
    
    func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if userImage.image != UIImage(named: "placeholder-user") {
            let zoomUserImageViewController = ZoomUserImageViewController()
            zoomUserImageViewController.userImage.image = self.userImage.image
            present(zoomUserImageViewController, animated: true, completion: nil)
        }
    }
    
}
