//
//  InsertDataViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/9/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

public enum InsertPopupType: String {
    case author = "authors"
    case category = "categories"
    case barcode = "barcode"
}

class InsertDataViewController: UIBasePopupViewController {

    var type: InsertPopupType = .author
    var basePopup: FHRPopupViewController?
    var urlString: String?
    var textString: String?
    var onClickCancel: (() -> Void)?
    // MARK: - Outlets
    @IBOutlet weak var nickNameView: UIView!
    @IBOutlet weak var contryView: UIView!
    @IBOutlet weak var authorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contenrView: UIView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        }
    }
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var lastTitleLabel: UILabel!
    @IBOutlet weak var lastTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.isHidden = true
        }
    }
    // MAKR: - Life circle
    
    init(type: InsertPopupType, textString: String? = nil) {
        super.init(nibName: InsertDataViewController.className, bundle: nil)
        self.type = type
        self.textString = textString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseViewController().photoPicker.delegate = self
        BaseViewController().photoPicker.allowsEditing = true
        self.configurationUI()
        
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.onClickCancel?()
    }
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        let cameraAction = "Camera".alertAction(style: .default) { (_ ) in
            BaseViewController().checkCamera()
        }
        let galleryAction = "Gallery".alertAction(style: .default) { (_ ) in
            BaseViewController().checkLibrary()
        }
        
        let alert = UIAlertController.Style.actionSheet.controller(title: nil, message: nil, actions: [cameraAction, galleryAction])
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        if type == .author {
            let authorParam = Author()
            authorParam.name = firstTextField.text!
            authorParam.nick_name = secondTextField.text!
            authorParam.contry = lastTextField.text!
            authorParam.avatar = urlString ?? ""
            Network.addNewData(parameter: authorParam, type: Author.self, completion: { isSuccess in
               self.onClickCancel?()
            })
        } else if type == .category {
            let categoryParam = Category()
            categoryParam.name = firstTextField.text!
            categoryParam.avatar = urlString ?? ""
            
            Network.addNewData(parameter: categoryParam, type: Category.self, completion: { isSuccess in
                self.onClickCancel?()
            })
        } else {
            Network.scannerQR(barcode: self.textString ?? "") { (isSuccess) in
                if isSuccess {
                    self.onClickCancel?()
                }
            }
        }
    }
    
    // MARK: - Functions
    private func configurationUI() {
        
        switch type {
        case .author:
            titleLabel.text = "Tên tác giả"
        case .category:
            titleLabel.text = "Tên thể loại"
            nickNameView.removeFromSuperview()
            contryView.removeFromSuperview()
        default:
            nickNameView.removeFromSuperview()
            contryView.removeFromSuperview()
            authorView.removeFromSuperview()
            titleLabel.removeFromSuperview()
            imageView.removeFromSuperview()
            
            contentLabel.isHidden = false
            contentLabel.text = self.textString
        }
        
        contenrView.clipsToBounds = true
    }
}

extension InsertDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                Network.uploadData(image: pickedImage, path: self.type == .author ? ("authors/") : ("categories/"), completionHandler: { (url) in
                    self.urlString = url?.absoluteString
                    self.imageView.image = pickedImage
                })
                self.reloadInputViews()
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
