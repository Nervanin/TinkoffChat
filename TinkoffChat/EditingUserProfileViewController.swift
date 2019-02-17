//
//  EditingUserProfileViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import SnapKit

class EditingUserProfileViewController: UIViewController {
    
    var userProfile = UserProfileModel()
    var userImage = UIImageView()
    var userName = UITextField()
    var userDescription = UITextField()
    var cancelButton = UIButton(type: .custom)
    var saveButton = UIButton(type: .custom)
    var setProfileImageButton = UIButton(type: .custom)
    var iconOfSetProfileImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(userImage)
        view.addSubview(userName)
        view.addSubview(userDescription)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        userImage.addSubview(setProfileImageButton)
        setProfileImageButton.addSubview(iconOfSetProfileImage)
        
        userImage.image = UIImage(named: userProfile.image)
        userImage.layer.cornerRadius = 48
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
        
        userName.delegate = self as? UITextFieldDelegate
        userName.placeholder = "Введите Ваше имя"
        userName.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userName.layer.borderWidth = 0.5
        userName.layer.cornerRadius = 10
        userName.font = UIFont.boldSystemFont(ofSize: 27.0)
        
        userDescription.placeholder = "Расскажите о себе"
        userDescription.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userDescription.layer.borderWidth = 0.5
        userDescription.layer.cornerRadius = 10
        
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
        
        setProfileImageButton.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.4705882353, blue: 0.9411764706, alpha: 1)
        setProfileImageButton.layer.cornerRadius = userImage.layer.cornerRadius
        
        iconOfSetProfileImage.image = UIImage(named: "slr-camera-2-xxl")
        
        cancelButton.addTarget(nil, action: #selector(cancelToProfile), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        let aspectRatioConstraint = NSLayoutConstraint(item: userImage,attribute: .height,relatedBy: .equal,toItem: userImage,attribute: .width,multiplier: (1),constant: 0)
        userImage.addConstraint(aspectRatioConstraint)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        userName.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        userName.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        userName.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        userName.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        userDescription.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        userDescription.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        userDescription.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        userDescription.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        userImage.snp.makeConstraints { (make) in
            
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        userName.snp.makeConstraints { (make) in
            
            make.top.equalTo(userImage.snp.bottom).offset(8)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(userDescription.snp.top).offset(-8)
        }
        
        userDescription.snp.makeConstraints { (make) in
            
            make.top.equalTo(userName.snp.bottom).offset(-8)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.bottom.equalTo(saveButton.snp.top).offset(-8)
        }
        
        saveButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(userDescription.snp.bottom).offset(8)
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
        
        setProfileImageButton.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(userImage).offset(0)
            make.right.equalTo(userImage).offset(0)
            make.width.greaterThanOrEqualTo(101)
            make.height.greaterThanOrEqualTo(101)
        }
        
        iconOfSetProfileImage.snp.makeConstraints { (make) in
            make.center.equalTo(setProfileImageButton)
            make.width.height.equalTo(60)
        }
    }
    
    @objc func cancelToProfile(_ sender: UIButton) {
        if sender == cancelButton {
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
    
}

