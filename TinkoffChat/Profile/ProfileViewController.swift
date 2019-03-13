//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, SetUserProfileImageProtocol, GestureRecognizerLogicForUserProfileImage {
    
    //lazy var editingUserProfileViewController = EditingUserProfileViewController()
    var userProfileModel = UserProfileModel()
    
    @IBOutlet weak var setProfileImageButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var editingButton: UIButton!
    
    @IBOutlet var setUpUserName: UITextField!
    @IBOutlet var setUpUserDescription: UITextView!
    
    @IBOutlet var GCDButton: UIButton!
    @IBOutlet var OperationButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    lazy var imagePicker = UIImagePickerController()
    lazy var singleTapGestureRecognizer = UITapGestureRecognizer()
    lazy var longPressGestureRecognizer = UILongPressGestureRecognizer()
    
    var dataSourceType: DataSourceType = .gcdDataManager
    
    var isEditMode: Bool = false {
        didSet {
            editingButton.isHidden = isEditMode
            userName.isHidden = isEditMode
            
//            GCDButton.isHidden = !isEditMode
//            OperationButton.isHidden = !isEditMode
            setUpUserDescription.isHidden = !isEditMode
            setUpUserName.isHidden = !isEditMode
        }
    }
    
    var isSaveButtonEnabled: Bool = false {
        didSet {
            GCDButton.isEnabled = isSaveButtonEnabled
            OperationButton.isEnabled = isSaveButtonEnabled
        }
    }
    
    lazy var successfulAlert: UIAlertController = {
        let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard let `self` = self else { return }
            self.loadData()
            self.isEditMode.toggle()
        }
        alert.addAction(action)
        return alert
    }()
    
    
    lazy var failureAlert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default)
        let repeatAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            guard let `self` = self else { return }
            self.saveData()
        }
        alert.addAction(okAction)
        alert.addAction(repeatAction)
        return alert
    }()
    
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
        imagePicker.delegate = self
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        editingButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editingButton.setTitle("Редактировать", for: .normal)
        editingButton.setTitleColor(.black, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateData()
        print(self.editingButton?.frame ?? "nil")
        /*
         Размеры фреймов кнопки "редактировать" в методах viewDidLoad и viewDidAppear отличаются потому что верстка в сториборде
         происходит на размере устройства Iphone SE. Тогда как по заданию тестировать приложение мы должны на устройстве Iphone
         X или Iphone 8 Plus. Если же тест делать на устройстве Iphone SE - frame кнопки "редактировать в 2-х выше перечисленных
         методах будет одинаков."
         */
    }
    
    private func saveData() {
        activityIndicator.startAnimating()
        isSaveButtonEnabled = false
        dataSourceType.dataSourceTypeManager().saveData(object: userProfileModel, file: Keys.profileState) { [weak self] error in
            guard let `self` = self else { return }
            self.activityIndicator.stopAnimating()
            self.isSaveButtonEnabled = true
            if let error = error {
                print("Error: \(error)")
                self.present(self.failureAlert, animated: true)
            } else {
                self.present(self.successfulAlert, animated: true)
            }
        }
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        isSaveButtonEnabled = false
        dataSourceType.dataSourceTypeManager().loadData(type: UserProfileModel.self, file: Keys.profileState) { [weak self] data, error in
            guard let `self` = self else { return }
            if let profileState = data {
                self.userProfileModel = profileState
            }
            self.updateData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func updateData() {
        self.userName.text = userProfileModel.name
        self.userDescription.text = userProfileModel.name
        self.setUpUserName.text = userProfileModel.name
        self.setUpUserDescription.text = userProfileModel.description
        if let imageData = userProfileModel.image {
            self.userImage.image = UIImage(data: imageData)
        }
    }
    
    struct Keys {
        static let profileState = "ProfileState"
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
    
    @IBAction func cancelToConversationsViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editingUserProfile(_ sender: Any) {
        editingButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editingButton.setTitleColor(.white, for: .normal)
        isEditMode.toggle()
        isSaveButtonEnabled = false

    }
    
    @IBAction func setImagePressed(_ sender: Any) {
        print("Выбери изображение профиля")
        chooseSourceForImageAlert()
    }
    
    
    @IBAction func cgdActionPressed(_ sender: Any) {
        dataSourceType = .gcdDataManager
        saveData()
    }
    
    @IBAction func operationActionPressed(_ sender: Any) {
        dataSourceType = .operationDataManager
        saveData()
    }
    
 

    
}

