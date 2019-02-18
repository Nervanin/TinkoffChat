//
//  EditingUserProfileViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import SnapKit

class EditingUserProfileViewController: UIViewController, SetUserProfileImageProtocol, GestureRecognizerLogicForUserProfileImage {
    
    let profileViewController = ProfileViewController()
    var userProfileModel = UserProfileModel()
    var userImage: UIImageView!
    var imageName = String()
    var setUserName = UITextField()
    var setUserDescription = UITextField()
    var cancelButton = UIButton(type: .custom)
    var saveButton = UIButton(type: .custom)
    var setUserProfileImageButton = UIButton(type: .custom)
    var iconOfSetProfileImage = UIImageView()
    lazy var imagePicker = UIImagePickerController()
    lazy var singleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var longPressGestureRecognizer = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userImage = UIImageView()
        view.addSubview(userImage)
        view.addSubview(setUserName)
        view.addSubview(setUserDescription)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        userImage.addSubview(setUserProfileImageButton)
        setUserProfileImageButton.addSubview(iconOfSetProfileImage)
        
        userImage.image = UIImage(named: imageName)
        userImage.layer.cornerRadius = 48
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleToFill
        
        setUserName.delegate = self as? UITextFieldDelegate
        setUserName.placeholder = "Введите Ваше имя"
        setUserName.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setUserName.layer.borderWidth = 0.5
        setUserName.layer.cornerRadius = 10
        setUserName.font = UIFont.boldSystemFont(ofSize: 27.0)
        setUserName.text = "123"
        
        setUserDescription.placeholder = "Расскажите о себе"
        setUserDescription.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setUserDescription.layer.borderWidth = 0.5
        setUserDescription.layer.cornerRadius = 10
        
        saveButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 10
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        
        cancelButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cancelButton.layer.borderWidth = 0.5
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.layer.cornerRadius = 10
        
        setUserProfileImageButton.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.4705882353, blue: 0.9411764706, alpha: 1)
        setUserProfileImageButton.layer.cornerRadius = userImage.layer.cornerRadius
        setUserProfileImageButton.addTarget(nil, action: #selector(setUserProfileImagePressed(_:)), for: .touchUpInside)
        
        iconOfSetProfileImage.image = UIImage(named: "slr-camera-2-xxl")
        
        cancelButton.addTarget(nil, action: #selector(cancelToProfile), for: .touchUpInside)
        
        saveButton.addTarget(nil, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        //actions for show and hide keyboard then user set info
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUpGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        //aspectRatio for userImagePlaceholder
        let aspectRatioConstraint = NSLayoutConstraint(item: userImage,attribute: .height,relatedBy: .equal,toItem: userImage,attribute: .width,multiplier: (1),constant: 0)
        userImage.addConstraint(aspectRatioConstraint)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        setUserName.translatesAutoresizingMaskIntoConstraints = false
        setUserDescription.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        setUserName.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        setUserName.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        setUserName.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        setUserName.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        setUserDescription.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        setUserDescription.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        setUserDescription.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        setUserDescription.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        userImage.snp.makeConstraints { (make) in
            
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        setUserName.snp.makeConstraints { (make) in
            
            make.top.equalTo(userImage.snp.bottom).offset(8)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(setUserDescription.snp.top).offset(-8)
        }
        
        setUserDescription.snp.makeConstraints { (make) in
            
            make.top.equalTo(setUserName.snp.bottom).offset(-8)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(saveButton.snp.top).offset(-8)
        }
        
        saveButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(setUserDescription.snp.bottom).offset(8)
            make.left.equalTo(view).offset(16)
            make.bottom.equalTo(view).offset(-16)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(150)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(view).offset(-16)
            make.left.equalTo(saveButton.snp.right).offset(16)
            make.width.equalTo(saveButton.snp.width)
            make.height.equalTo(saveButton.snp.height)
        }
        
        setUserProfileImageButton.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(userImage).offset(0)
            make.right.equalTo(userImage).offset(0)
            make.width.greaterThanOrEqualTo(101)
            make.height.greaterThanOrEqualTo(101)
        }
        
        iconOfSetProfileImage.snp.makeConstraints { (make) in
            make.center.equalTo(setUserProfileImageButton)
            make.width.height.equalTo(60)
        }
    }
    
    @objc func setUserProfileImagePressed(_ sender: UIButton) {
        chooseSourceForImageAlert()
    }
    
    func setUpGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped(tapGestureRecognizer:)))
        let longGesureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
        userImage.addGestureRecognizer(longGesureRecognizer)
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.delegate = self
    }
    
    //MARK: settings
    @objc func saveButtonPressed(_ sender: UIButton) {
        if sender == saveButton {
            userProfileModel.name = setUserName.text ?? userProfileModel.name
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: settings action of cancel button
    @objc func cancelToProfile(_ sender: UIButton) {
        if sender == cancelButton {
            cancelButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cancelButton.setTitleColor(.white, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
