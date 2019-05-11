//
//  BaseViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import SVProgressHUD
import Photos

class BaseViewController: UIViewController {
    
    let photoPicker = UIImagePickerController()
    let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    let photos = PHPhotoLibrary.authorizationStatus()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
    }
    
    // MARK: - Private Functions
    
    private func configurationUI() {
        
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func checkCamera(){
        switch cameraAuthorizationStatus {
        case .notDetermined: requestCameraPermission(type: 0)
        case .authorized: presentCamera(sourceType: .camera)
        case .restricted, .denied: alertCameraAccessNeeded(type: 0)
        @unknown default:
            break
        }
    }
    
    func checkCameraScan(){
        switch cameraAuthorizationStatus {
        case .notDetermined: requestCameraPermission(type: 0)
        case .authorized: break
        case .restricted, .denied: alertCameraAccessNeeded(type: 0)
        @unknown default:
            break
        }
    }
    
    @objc
    func onTapLeftBarButtonItem() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkLibrary(){
        switch photos {
        case .notDetermined: requestCameraPermission(type: 1)
        case .authorized: presentCamera(sourceType: .photoLibrary)
        case .restricted, .denied: alertCameraAccessNeeded(type: 1)
        @unknown default:
            break
        }
    }
    
    func requestCameraPermission(type: Int) {
        if type == 0 {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
                guard accessGranted == true else { return }
                self.presentCamera(sourceType: .camera)
            })
        }else {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.presentCamera(sourceType: .photoLibrary)
                }
            }
        }
    }
    
    func presentCamera(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            photoPicker.sourceType = sourceType
            self.present(photoPicker, animated: true, completion: nil)
        }else {
            let alert = UIAlertController.Style.alert.controller(message: "You don't have camera", actions: ["OK".alertAction(style: .cancel, handler: nil)])
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertCameraAccessNeeded(type: Int) {
        let vc = RequestAuthorViewController.newInstance()
        vc.type = type
        self.present(vc, animated: true, completion: nil)
    }
    
    func showLoading() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(UIColor(red: 0, green: 154, blue: 221, alpha: 1))
        SVProgressHUD.show()
    }
}

