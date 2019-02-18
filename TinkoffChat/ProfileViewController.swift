//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, SetUserProfileImageProtocol, GestureRecognizerLogicForUserProfileImage {
    
    lazy var editingUserProfileViewController = EditingUserProfileViewController()
    var userProfileModel = UserProfileModel()
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
        userImage.layer.cornerRadius = userImage.bounds.height / 6
        userImage.clipsToBounds = true
        
        userImage.image = UIImage(named: "placeholder-user")
        setProfileImageButton.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.4705882353, blue: 0.9411764706, alpha: 1)
        setProfileImageButton.layer.cornerRadius = userImage.layer.cornerRadius
        
        editingButton.layer.cornerRadius = 15
        editingButton.layer.borderWidth = 1
        editingButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editingButton.clipsToBounds = true
        
        setUpGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if editingUserProfileViewController.userProfileModel.image != UIImage(named: "placeholder-user") {
            userImage.image = editingUserProfileViewController.userProfileModel.image
        }
        userName.text = editingUserProfileViewController.userProfileModel.name
        userDescription.text = editingUserProfileViewController.userProfileModel.discription
        
        editingButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editingButton.setTitle("Редактировать", for: .normal)
        editingButton.setTitleColor(.black, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print(self.editingButton?.frame ?? "nil")
        /*
         Размеры фреймов кнопки "редактировать" в методах viewDidLoad и viewDidAppear отличаются потому что верстка в сториборде
         происходит на размере устройства Iphone SE. Тогда как по заданию тестировать приложение мы должны на устройстве Iphone
         X или Iphone 8 Plus. Если же тест делать на устройстве Iphone SE - frame кнопки "редактировать в 2-х выше перечисленных
         методах будет одинаков."
         */
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
    
    @IBAction func editingUserProfile(_ sender: Any) {
        editingButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editingButton.setTitleColor(.white, for: .normal)
        present(editingUserProfileViewController, animated: true, completion: nil)
    }
    
    @IBAction func setImagePressed(_ sender: Any) {
        print("Выбери изображение профиля")
        chooseSourceForImageAlert()
    }
    
}

