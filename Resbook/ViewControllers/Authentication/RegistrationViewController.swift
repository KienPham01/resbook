//
//  RegistrationViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confimPasswordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hiddenNavigation()
    }
    
    @IBAction func backToLoginButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        showLoading()
        let parameter = UserProfileParameter()
        parameter.mail_address = emailTextField.text ?? ""
        parameter.user_name = usernameTextField.text ?? ""
        if passwordTextField.text == confimPasswordTextField.text {
            parameter.password = passwordTextField.text
        }
        
        Network.signUp(parameter: parameter) { (isSuccess, message) in
            if !isSuccess {
                let alertFail = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel)])
                self.present(alertFail, animated: true, completion: {
                    self.hideLoading()
                })
            } else {
                self.hideLoading()
                Network.getUserProfile(completionHandler: { (userProfile) in
                    DataServices.sharedInstance.userProfile = userProfile
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let dashboard = storyboard.instantiateViewController(withIdentifier: "Dashboard")
                    AppDelegate.sharedInstance.window?.rootViewController = dashboard
                })
            }
        }
    }
    static func newInstance() -> RegistrationViewController {
        return LoginViewController.instantiateFromStoryboardHelper(storyboardName: .authentication, storyboardId: RegistrationViewController.className)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    private func hiddenNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
}
