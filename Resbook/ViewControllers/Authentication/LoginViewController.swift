//
//  LoginViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import GoogleSignIn
public enum LoginType: String {
    case facebook = "Facebook"
    case google = "Google"
    case phonenumber = "Phone number"
}

class LoginViewController: BaseViewController, GIDSignInUIDelegate {
    // MARK: - Outlets
    var loginType: LoginType?
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleLoginButton: UIButton! {
        didSet {
            GIDSignIn.sharedInstance().uiDelegate = self
        }
    }
    
    // MARK: - Life circles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hiddenNavigation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.showLoading()
        if let email = emailTextField.text, let password = passwordTextField.text {
            if email.isValidEmail() && password.isValidPassword() {
                Network.login(email: email, password: password, social: nil) { (isSuccess, message) -> Void in
                    if !isSuccess {
                        let alertFail = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel)])
                        self.present(alertFail, animated: true, completion: {
                            self.hideLoading()
                        })
                    } else {
                        Network.getUserProfile(completionHandler: { (userProfile) in
                            self.hideLoading()
                            DataServices.sharedInstance.userProfile = userProfile
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let dashboard = storyboard.instantiateViewController(withIdentifier: "Dashboard")
                            AppDelegate.sharedInstance.window?.rootViewController = dashboard
                        })
                    }
                }
            }
        }
        
    }
    @IBAction func loginViaSocialButtonTapped(_ sender: UIButton) {
        loginType = LoginType.init(rawValue: sender.titleLabel?.text ?? "")
        Network.loginWithSocial(self, socialType: loginType!) { (isSuccess, message) in
            if isSuccess {
                Network.getUserProfile(completionHandler: { (userProfile) in
                    self.hideLoading()
                    DataServices.sharedInstance.userProfile = userProfile
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let dashboard = storyboard.instantiateViewController(withIdentifier: "Dashboard")
                    AppDelegate.sharedInstance.window?.rootViewController = dashboard
                })
            }
        }
        if loginType?.rawValue == LoginType.phonenumber.rawValue {
            let alert = UIAlertController.Style.alert.controller(message: "Login with phone number doesn't support.", actions: ["OK".alertAction(style: .cancel)])
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let registration = RegistrationViewController.newInstance()
        self.navigationController?.pushViewController(registration, animated: true)
    }
    
    // MARK: - Functions
    static func newInstance() -> LoginViewController {
        return LoginViewController.instantiateFromStoryboardHelper(storyboardName: .authentication, storyboardId: LoginViewController.className)
    }
    
    private func hiddenNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
}
