//
//  AppDelegate.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/2/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import GoogleSignIn
import SideMenu
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var ref: DatabaseReference!
    var storageRef: Storage!
    
    static var sharedInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configuration()
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if url.absoluteString.hasPrefix("fb402080520647928://") {
            return FBSDKApplicationDelegate.sharedInstance().application(
                app,
                open: url as URL?,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        } else {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
        }
        
    }
    
    private func configuration() {
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.white
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.7
        SideMenuManager.default.menuLeftNavigationController = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        IQKeyboardManager.shared.enable = true
        
        // Change navigation color
        UINavigationBar.appearance().barTintColor = .init(red: 0.215, green: 0.277, blue: 0.312, alpha: 1.0)
        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = .white
        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = false
        
        
        FirebaseApp.configure()
        ref = Database.database().reference()
        storageRef = Storage.storage()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        checkingUser()
    }
    
    private func checkingUser() {
        if Auth.auth().currentUser != nil {
            Network.getUserProfile { (userProfile) in
                DataServices.sharedInstance.userProfile = userProfile
                let storyboard = UIStoryboard.init(name: StoryBoardName.dashboard.rawValue, bundle: nil)
                let dashboard = storyboard.instantiateViewController(withIdentifier: "Dashboard")
                self.window?.rootViewController = dashboard
            }        
        } else {
            let navigation = UINavigationController(rootViewController: LoginViewController.instantiateFromStoryboardHelper(storyboardName: .authentication, storyboardId: LoginViewController.className))
            self.window?.rootViewController = navigation
        }
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            return
        } else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                guard let uid = authResult?.user.uid else {
                    return
                }
                
                let subChildRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "firebase_users").child(uid)
                subChildRef.observe(.value, with: { (snapshot) in
                    let paramValue = ["mail_address": authResult?.user.email,
                                      "avatar": authResult?.user.photoURL?.absoluteString ?? "" + "?type=large",
                                      "user_name": authResult?.user.displayName,
                                      "user_type": "google"
                    ]
                    subChildRef.setValue(paramValue)
                    
                    Network.getUserProfile { (userProfile) in
                        DataServices.sharedInstance.userProfile = userProfile
                        let storyboard = UIStoryboard.init(name: StoryBoardName.dashboard.rawValue, bundle: nil)
                        let dashboard = storyboard.instantiateViewController(withIdentifier: "Dashboard")
                        self.window?.rootViewController = dashboard
                    }
                })
                
            }
        }
    }
}

