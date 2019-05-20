//
//  AuthenticationNetwork.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import ObjectMapper
import FBSDKLoginKit
import GoogleSignIn
import FirebaseStorage

extension Network {
    
    static let instance = Network()
    
    
    
    static var isLogin: Bool {
        return Auth.auth().currentUser != nil
    }
    
    public static func login(email: String?, password: String?, social: String?, completionHandler: @escaping (Bool, String?) -> Void) {
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    completionHandler(false, error?.localizedDescription ?? "")
                } else {
                    switch result {
                    case .none:
                        completionHandler(false, "Contact to the administration")
                    case .some( _):
                        completionHandler(true, nil)
                    }
                }
            }
        }
    }
    
    public static func getUserProfile(completionHandler: @escaping (UserProfile?) -> Void){
        if self.isLogin {
            let uid = Auth.auth().currentUser!.uid
            AppDelegate.sharedInstance.ref.database.reference(withPath: "/firebase_users/\(uid)").observe(.value) { (snapshot) in
                
                if let result = snapshot.value as? [String: String] {
                    let userProfile = UserProfile(JSON: result)
                    
                    completionHandler(userProfile)
                }
            }
        }
        completionHandler(nil)
    }
    
    
    
    
    /* get All FeedMessage */
    
//    public static func getFeedMessages(hander:@escaping (FeedMessage?) -> Void){
//
//        AppDelegate.sharedInstance.ref.database.reference(withPath:"conversation/seach_user_response").observe(.value) { (feedMessageSnapshot) in
//
//
//            if let feed =  feedMessageSnapshot.value as? [String:Any]{
//
//                let feedMessage  = FeedMessage(JSON: feed)
//                hander(feedMessage)
//            }
//        }
//        hander(nil)
//
//
//    }
    public static func getSearchUser(handler: @escaping (_ messages: [FeedMessage]) -> ()) {
        var messageArray = [FeedMessage]()


        AppDelegate.sharedInstance.ref.database.reference(withPath: "conversation/seach_user_response").observe(.value) { (searchUser) in

            guard let searchUser = searchUser.children.allObjects as? [DataSnapshot] else { return }

            for message in searchUser {
//                do{
                    guard  let status  = message.childSnapshot(forPath: "find_status").value else{return}
                    
                    if status as! Int != 0{
                        
                            let user_id = message.childSnapshot(forPath: "user_id").value  as! String
                        
                        
                        let message1 = FeedMessage(user_id: user_id, status: status as! Int)
                        
                        messageArray.append(message1)
                        
                    
                        
                    }
                
//
                    
                    
                

//                }
//                catch{
//                    let user_id1 = "123"
//                    let status1 = 0
//                    let message = FeedMessage(user_id: user_id1 , status: status1)
//                    messageArray.append(message)
//
//
//
//                }

                



            }

            handler(messageArray)
        }


    }
    
    /* upload post*/
    
    
    public static func insertUser(withMessage message: String,forUid uid:String,withGroupKey groupKey:String?,sendComplete: @escaping (_ _status:Bool) ->()){
        
        
        if groupKey == nil{
        
            AppDelegate.sharedInstance.ref.database.reference(withPath: "conversation/seach_user_request").childByAutoId().updateChildValues(["user_name": message,"token":uid])
            
            sendComplete(true)
        }else{
            
            
            
        }
    }
    func getIds(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        AppDelegate.sharedInstance.ref.database.reference().child("").observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "").value as! String
                
//                if usernames.contains(email) {
//                    idArray.append(user.key)
//                }
            }
            handler(idArray)
        }
    }
//
    public static func getAllFeed (forUid uid:String,handler: @escaping (_ message:[Channel]) -> ()){
        
        let id = "6qJtHBfwWiSzjRbCjGRjh0lfurr1"
        var feedArray = [Channel]()
        AppDelegate.sharedInstance.ref.database.reference().child("conversation/receivers/\(id)/list_receiver").observeSingleEvent(of: .value){(feedMessageSnapshot) in
            
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for feed in feedMessageSnapshot{
                
                let chanel_id = feed.childSnapshot(forPath: "channel_id").value as! String
                let red = feed.childSnapshot(forPath: "red").value as! Int
                
                let feedMessage = Channel(key: chanel_id, red: red)
                
                feedArray.append(feedMessage)
                
                
            }
            handler(feedArray)
            
            
        }





    }
    public static func getEmail(forSearchQuery query:String ,handler:@escaping (_ emailArray:[String]) -> ()){
        
        var emailArray = [String] ()
        AppDelegate.sharedInstance.ref.database.reference(withPath: "conversation/seach_user_response").observe(.value){ (userSnapshot) in
            
            guard  let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                
                let user_id = user.childSnapshot(forPath: "user_id").value as! String
                
                if user_id.contains(query) == true && user_id != Auth.auth().currentUser?.uid{
//                    let getuser = UserSearchProfile(user: email, avatar: profile)
                    emailArray.append(user_id)
                }
            }
            handler(emailArray)
        }
    
    
    }
    

    
    
    
    public static func updateUserProfile(parameter: UserProfileParameter, completionHandler: @escaping (String) -> Void) {
        if self.isLogin {
            let uid = Auth.auth().currentUser!.uid
            
            AppDelegate.sharedInstance.ref.database.reference(withPath: "firebase_users/\(uid)").updateChildValues(parameter.toJSON()) { (error, reference) in
                if error == nil {
                    completionHandler("Update Success")
                } else {
                    completionHandler(error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    public static func signUp(parameter: UserProfileParameter, completionHandler: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: parameter.mail_address, password: parameter.password!) { (result, error) in
            if error != nil {
                completionHandler(false, error?.localizedDescription ?? "")
            } else {
                switch result {
                case .none:
                    completionHandler(false, "Contact to the administration")
                case .some( let user):
                    let subChildRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "firebase_users").child(user.user.uid)
                    print("UID: \(user.user.uid)")
                    let paramValue = ["mail_address": parameter.mail_address,
                                      "user_name": parameter.user_name,
                                      "user_type": "email"
                    ]
                    subChildRef.setValue(paramValue)
                    completionHandler(true, nil)
                }
            }
        }
    }
    
    //get all messages
    
    
    
    
    
    // Login with social
    public static func loginWithSocial(_ viewController: UIViewController, socialType: LoginType, completionHandler: @escaping (Bool, String)->Void) {
        switch socialType {
        case .facebook:
            self.connectingFacebook(viewController) { (accessToken) in
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                (viewController as! BaseViewController).showLoading()
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
                    if error != nil {
                        completionHandler(false, error?.localizedDescription ?? "")
                    } else {
                        guard let uid = authResult?.user.uid else {
                            completionHandler(false, "Something error. Try again")
                            return
                        }
                        let subChildRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "firebase_users").child(uid)
                        subChildRef.observe(.value, with: { (snapshot) in
                            
                            if snapshot.exists() {
                                completionHandler(true, "Login Success")
                            } else {
                                
                                let paramValue = ["mail_address": authResult?.user.email,
                                                  "avatar": authResult?.user.photoURL?.absoluteString ?? "" + "?type=large",
                                                  "user_name": authResult?.user.displayName,
                                                  "user_type": "facebook"
                                ]
                                subChildRef.setValue(paramValue)
                                
                                completionHandler(true, "Login Success")
                            }
                        })
                    }
                })
            }
        default:
            googleLogin()
        }
    }
    
    private static func connectingFacebook(_ viewController: UIViewController, _ completionHandler: @escaping (_ accessToken: String) -> Void = {_ in }) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        if  UIApplication.shared.canOpenURL(URL(string: "fb:\(402080520647928)//")!){
            fbLoginManager.loginBehavior = .native
        } else {
            fbLoginManager.loginBehavior = .browser
        }
        
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile"], from: viewController) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!

                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        if let token = fbloginresult.token.tokenString {
                            completionHandler(token)
                        }
                    }
                }
            } else {
                let alertFail = UIAlertController.Style.alert.controller(message: "Can't connect to facebook", actions: ["OK".alertAction(style: .cancel, handler: nil)])
                viewController.present(alertFail, animated: true, completion: nil)
            }
        }
    }
    
    public static func googleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    public static func signOut() {
        try! Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        DataServices.sharedInstance.userProfile = nil
        let navigation = UINavigationController(rootViewController: LoginViewController.newInstance())
        AppDelegate.sharedInstance.window?.rootViewController = navigation
    }
    
    public static func uploadData(image: UIImage, path: String, fileName: String? = nil, completionHandler: @escaping (URL?) -> Void)  {
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completionHandler(nil)
            return
        }
        
        let uuid = fileName != nil ? (fileName) : (UUID().uuidString)
        let storageRef = AppDelegate.sharedInstance.storageRef.reference().child(path).child(uuid!)
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            storageRef.downloadURL(completion: { (url, error) in
               completionHandler(url)
                
            })
        }
    }
    
    public static func uploadAvatar(image: UIImage, completionHandler: @escaping (Bool, String?) -> Void) {
        
        self.uploadData(image: image, path: "avatars/") { (url) in
            if url != nil {
                completionHandler(false, "Error to upload avatar")
            } else {
                guard let uid = Auth.auth().currentUser?.uid else {
                    completionHandler(false, "Something error. Try again")
                    return
                }
                
                let subChildRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "firebase_users").child(uid)
                let parameter = ["avatar": url?.absoluteString]
                subChildRef.updateChildValues(parameter as [AnyHashable : Any])
                
                completionHandler(true, nil)
            }
        }
    }
}
