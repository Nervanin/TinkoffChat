//
//  Protocols.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import UIKit

// MAKR: ChooseSourceForImageAlert protocol
// protocol for extension Profile and EditingUserProfile VC. via him we cah shoose image by photo libriarry or camera
protocol ChooseSourceForImageAlert  {
    var userImage: UIImageView! { get set }
    var imagePicker: UIImagePickerController { get set }
    func chooseSourceForImageAlert()
    func chooseImagePickerAction(source: UIImagePickerController.SourceType)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
}

extension ChooseSourceForImageAlert {
    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func chooseSourceForImageAlert() {
        let alertController = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { (action) in
            self.chooseImagePickerAction(source: .camera)
        }
        let photoLibriaryAction = UIAlertAction(title: "Фото из библиотеки", style: .default) { (action) in
            self.chooseImagePickerAction(source: .photoLibrary)
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
            self.userImage.image = UIImage(named: "placeholder-user")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibriaryAction)
        if userImage.image != UIImage(named: "placeholder-user") {
            alertController.addAction(deleteAction)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        userImage.image = info[.editedImage] as? UIImage
    }
}

// MAKR: gestureRecognizerFunctions protocol
//protocol for extension Profile and EditingUserProfile VC. via him we cah choose image by photo libriarry or camera by long press on image or we can Zoom image by one tap
 protocol GestureRecognizerFunctions {
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


extension GestureRecognizerFunctions {
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
