//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userProfile = UserProfile()
    @IBOutlet weak var setProfileImageButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var editingButton: UIButton!
    lazy var imagePicker = UIImagePickerController()
    lazy var singleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var longPressGestureRecognizer = UILongPressGestureRecognizer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(editingButton?.frame ?? "nil")
        /*
            Мы получим "nil", потому что в методе init ещё не существует UI элементов,
            соответственно и frame UI элементов так же не существует)
         */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(editingButton?.frame ?? "nil")
        
        userImage.image = UIImage(named: userProfile.image)
        userImage.layer.cornerRadius = userImage.bounds.height / 6
        userImage.clipsToBounds = true
        
        userName.text = userProfile.name
        
        userDescription.text = userProfile.discription
        
        setProfileImageButton.backgroundColor = #colorLiteral(red: 0.3076745272, green: 0.5609909296, blue: 0.9542145133, alpha: 1)
        setProfileImageButton.layer.cornerRadius = userImage.layer.cornerRadius
        
        editingButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editingButton.layer.cornerRadius = 15
        editingButton.layer.borderWidth = 1
        editingButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editingButton.clipsToBounds = true
        
        setGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.editingButton?.frame ?? "nil")
        /*
         Размеры фреймов кнопки "редактировать" в методах viewDidLoad и viewDidAppear отличаются потому что верстка в сториборде
         происходит на размере устройства Iphone SE. Тогда как по заданию тестировать приложение мы должны на устройстве Iphone
         X или Iphone 8 Plus. Если же тест делать на устройстве Iphone SE - frame кнопки "редактировать в 2-х выше перечисленных
         методах будет одинаков."
         */
    }
    
}

//Here we can set user photo in the profile
extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func chouseImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func setImagePressed(_ sender: Any) {
        print("Выбери изображение профиля")
        chooseSourceForImageAlert()
    }
    
    func chooseSourceForImageAlert() {
        let alertController = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { (action) in
            self.chouseImagePickerAction(source: .camera)
        }
        let photoLibriaryAction = UIAlertAction(title: "Фото из библиотеки", style: .default) { (action) in
            self.chouseImagePickerAction(source: .photoLibrary)
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
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        userImage.image = info[.editedImage] as? UIImage
    }
    
}

// extention for user image. Here add TapGesture for user image
extension ProfileViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer === singleTapGestureRecognizer && otherGestureRecognizer === longPressGestureRecognizer
    }
    
    func setGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped(tapGestureRecognizer:)))
        let longGesureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
        userImage.addGestureRecognizer(longGesureRecognizer)
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.delegate = self
    }
    
    @objc func imageLongPressed(tapGestureRecognizer: UILongPressGestureRecognizer) {
        chooseSourceForImageAlert()
    }
    
    @objc func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if userImage.image != UIImage(named: "placeholder-user") {
            let zoomUserImageViewController = ZoomUserImageViewController()
            zoomUserImageViewController.userImage.image = self.userImage.image
            present(zoomUserImageViewController, animated: true, completion: nil)
        }
    }
    
}
