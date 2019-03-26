//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    lazy var imagePicker = UIImagePickerController()
    lazy var singleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var longPressGestureRecognizer = UILongPressGestureRecognizer()
    @IBOutlet var informationView: UIView!
    @IBOutlet var editionView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var informationField: UITextField!
    @IBOutlet var profilePhotoConstraint: NSLayoutConstraint!
    @IBOutlet var saveButtonConstraint: NSLayoutConstraint!
    let imagePickerController = UIImagePickerController()
    let profileEdititionModel = ProfileModel()
    var fieldsChanged = false
    
    @IBAction func chooseProfilePhoto(_ sender: UIButton) {
        let choosePhotoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        choosePhotoAlert.addAction(UIAlertAction(title: "Установить из галереи", style: .default, handler: { (alertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }))
        choosePhotoAlert.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { (alertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true)
            } else {
                let noCameraAlert = UIAlertController(title: nil, message: "На этом устройстве нет камеры", preferredStyle: .alert)
                noCameraAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(noCameraAlert, animated: true)
            }
        }))
        choosePhotoAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(choosePhotoAlert, animated: true)
    }
    
    @IBAction func editProfileInformation(_ sender: UIButton) {
        self.informationView.isHidden = true
        self.editionView.isHidden = false
        self.toggleSaveButton(enabled: false)
        self.nameField.text = self.nameLabel.text
        self.informationField.text = self.informationLabel.text
    }
    
    @IBAction func saveInformation(_ sender: UIButton) {
        self.saveProfile()
    }
    
    @IBAction func dismissProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateProfileData() {
        CoreDataManager.loadProfile(callback: { [weak self] profileData in
            if let profile = profileData {
                self?.nameLabel.text = profile.name ?? "User Name"
                self?.informationLabel.text = profile.information
                self?.userImage.image = profile.image ?? self?.userImage.image
            } else {
                self?.nameLabel.text = "User Name"
            }
        })
    }
    
    func saveProfile() {
        self.updateEditionModel()
        self.toggleSaveButton(enabled: false)
        self.dismissKeyboard()
        self.choosePhotoButton.isEnabled = false
        self.activityIndicator.startAnimating()
        CoreDataManager.saveProfile(model: self.profileEdititionModel) { [weak self] success in
            self?.activityIndicator.stopAnimating()
            self?.choosePhotoButton.isEnabled = true
            self?.toggleSaveButton(enabled: true)
            if success {
                self?.showSuccessSaveAlert()
            } else {
                self?.showErrorSaveAlert()
            }
        }
    }
    
    func exitEditMode() {
        self.editionView.isHidden = true
        self.informationView.isHidden = false
        self.fieldsChanged = false
        self.updateProfileData()
    }
    
    func showSuccessSaveAlert() {
        let alert = UIAlertController(title: nil, message: "Данные сохранены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            self?.exitEditMode()
        }))
        self.present(alert, animated: true)
    }
    
    func showErrorSaveAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] action in
            self?.saveProfile()
        }))
        self.present(alert, animated: true)
    }
    
    func toggleSaveButton(enabled: Bool) {
        self.saveButton.isEnabled = enabled
        self.saveButton.alpha = enabled ? 1 : 0.3
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !self.fieldsChanged {
            self.toggleSaveButton(enabled: true)
            self.fieldsChanged = true
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        self.profilePhotoConstraint.constant = -keyboardFrame.height + 16
        self.saveButtonConstraint.constant = keyboardFrame.height
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide() {
        self.profilePhotoConstraint.constant = 16
        self.saveButtonConstraint.constant = 0
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    func updateEditionModel() {
        if self.nameLabel.text != self.nameField.text {
            self.profileEdititionModel.name = self.nameField.text
        }
        if self.informationLabel.text != self.informationField.text {
            self.profileEdititionModel.information = self.informationField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        self.updateProfileData()
        self.editionView.isHidden = true
        self.nameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.informationField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        saveButton.clipsToBounds = true
        editButton.layer.cornerRadius = 15
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
