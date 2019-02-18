//
//  Protocols.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//


import UIKit

// MAKR: ChooseSourceForImageAlert protocol
// protocol for extension Profile and EditingUserProfile VC. via him we cah shoose image by photo libriarry or camera
protocol SetUserProfileImageProtocol  {
    var userImage: UIImageView! { get set }
    var imagePicker: UIImagePickerController { get set }
    func chooseSourceForImageAlert()
    func chooseImagePickerAction(source: UIImagePickerController.SourceType)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
}

extension SetUserProfileImageProtocol {
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
