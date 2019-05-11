//
//  UserProfileViewController.swift
//  
//
//  Created by Thuy Truong Quang on 5/3/19.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    let currentUserProfile = DataServices.sharedInstance.userProfile
    
    @IBOutlet weak var avatarBanner: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.onTapLeftBarButtonItem()
    }
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        let cameraAction = "Camera".alertAction(style: .default) { (_ ) in
            self.checkCamera()
        }
        let galleryAction = "Gallery".alertAction(style: .default) { (_ ) in
            self.checkLibrary()
        }
        
        let alert = UIAlertController.Style.actionSheet.controller(title: nil, message: nil, actions: [cameraAction, galleryAction])
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func updateProfileButtonTapped(_ sender: UIButton) {
        showLoading()
        let param = UserProfileParameter()
        var isError = false
        if currentUserProfile?.phonenumber != "" {
            if phonenumberTextField.text! == "" {
                param.phonenumber = phonenumberTextField.text ?? ""
            }
        }
        
        if currentUserProfile?.mail_address != "" {
            if emailTextField.text! == "" {
               param.mail_address = emailTextField.text ?? ""
            }
        }
        
        if !phonenumberTextField.text!.isEmpty {
            if phonenumberTextField.text!.isValidPhone() {
                param.phonenumber = phonenumberTextField.text ?? ""
            } else {
                isError = true
            }
        }
        
        if !emailTextField.text!.isEmpty {
            if emailTextField.text!.isValidEmail() {
                param.mail_address = emailTextField.text ?? ""
            } else {
                isError = true
            }
        }
        
        if !isError {
            param.user_name = usernameTextField.text ?? ""
            param.address = addressTextField.text ?? ""
            self.showLoading()
            
            Network.updateUserProfile(parameter: param) { (message) in
                let alert = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel, handler: nil)])
                self.present(alert, animated: true, completion: {
                    self.hideLoading()
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//         hiddenNavigation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoPicker.delegate = self
        self.photoPicker.allowsEditing = true
        configuration()
       
    }
    
    static func newInstance() -> UserProfileViewController {
        return UserProfileViewController.instantiateFromStoryboardHelper(storyboardName: .dashboard, storyboardId: UserProfileViewController.className)
    }
    
    private func hiddenNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
    private func configuration() {
        avatarBanner.loadImage(url: currentUserProfile?.avatar ?? "", placeHolderImage: #imageLiteral(resourceName: "user"))
        emailTextField.text = currentUserProfile?.mail_address
        usernameTextField.text = currentUserProfile?.user_name
        addressTextField.text = currentUserProfile?.address
        phonenumberTextField.text = currentUserProfile?.phonenumber
    }
    
}
extension UserProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                Network.uploadAvatar(image: pickedImage, completionHandler: { (isSuccess, message) in
                    self.showLoading()
                    if isSuccess {
                        self.avatarBanner.image = pickedImage
                        self.hideLoading()
                    } else {
                        let alert = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel, handler: nil)])
                        self.present(alert, animated: true, completion: {
                            self.hideLoading()
                        })
                    }
                })
                self.reloadInputViews()
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
