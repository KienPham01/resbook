//
//  CreateNewBookViewController.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import Photos

class CreateNewBookViewController: BaseViewController {
    // MARK: - Life Cricle
    let parameter = BookInformationParameter()

    // MARK: - Outlets
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var purchasePriceTextField: UITextField!
    @IBOutlet weak var salePriceTextField: UITextField!
    @IBOutlet weak var loanButton: CheckBox!
    @IBOutlet weak var dateLoanTextField: UITextField!
    @IBOutlet weak var quanlityTextField: UITextField!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoPicker.delegate = self
        self.photoPicker.allowsEditing = true
        
        
        configurationUI()
    }
    
    // MAKR: - Actions
    @IBAction func authorButtonTapped(sender: UIButton) {
        Network.getList(type: Author.self) { (isSuccess, data) in
            if isSuccess {
                let authorTVC = BaseTableViewController<Author>(data: data ?? [])
                authorTVC.tableView.reloadData()
                authorTVC.tableView.reloadInputViews()
                self.navigationController?.pushViewController(authorTVC, animated: true)
                
                authorTVC.onSelection = { [weak self] item in
                    self?.parameter.author_id = item.uid
                    self?.parameter.author_name = item.name
                    
                    self?.authorButton.setTitle(item.name, for: .normal)
                }
            }
        }
    }
    
    @IBAction func categoryButtonTapped(sender: UIButton) {
        
        Network.getList(type: Category.self) { (isSuccess, data) in
            if isSuccess {
                let authorTVC = BaseTableViewController<Category>(data: data ?? [])
                authorTVC.tableView.reloadData()
                authorTVC.tableView.reloadInputViews()
                
                self.navigationController?.pushViewController(authorTVC, animated: true)
                
                authorTVC.onSelection = { [weak self] item in
                    
                    self?.parameter.category_id = item.uid
                    self?.parameter.category_name = item.name
                    
                    self?.categoryButton.setTitle(item.name, for: .normal)
                }
            }
        }
        
    }
    
    @IBAction func uploadImageButtonTapped(sender: UIButton) {
        let cameraAction = "Camera".alertAction(style: .default) { (_ ) in
            self.checkCamera()
        }
        let galleryAction = "Gallery".alertAction(style: .default) { (_ ) in
            self.checkLibrary()
        }
        
        let alert = UIAlertController.Style.actionSheet.controller(title: nil, message: nil, actions: [cameraAction, galleryAction])
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveBarButtonItemTapped(sender: UIBarButtonItem) {
        
        parameter.name = titleTextField.text
        parameter.plot_overview = descriptionTextView.text
        parameter.cover_price = Int(priceTextField.text ?? "")
        
        let parameterBookItem = BookItemParameter()
        parameterBookItem.free_loan = loanButton.isSelected
        parameterBookItem.numdays_borrow = Int(dateLoanTextField.text ?? "")
        parameterBookItem.purchase_price = Int(purchasePriceTextField.text ?? "")
        parameterBookItem.sale_price = Int(salePriceTextField.text ?? "")
        parameterBookItem.quantity = Int(quanlityTextField.text ?? "")
        Network.submitBook(parameter: parameter, parameterBookItem: parameterBookItem) { (isSuccess, message) in
            if !isSuccess {
                let alert = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel, handler: nil)])
                self.present(alert, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MAKR: - Functions
    private func configurationUI() {
    }
    
    private func validateInput(keyName: String) -> Bool {
        if keyName != "" {
            return true
        } else {
            let alert = UIAlertController.Style.alert.controller(message: "The \(keyName) is not empty.", actions: ["OK".alertAction(style: .cancel, handler: nil)])
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
    }
}

extension CreateNewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                if let asset = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                    let fileName = asset.lastPathComponent
                    
                    self.showLoading()
                    
                    Network.uploadData(image: pickedImage, path: "books/", fileName: fileName, completionHandler: { (url) in
                        if url != nil {
                            self.parameter.image = url?.absoluteString
                            self.titleImage.image = pickedImage
                            self.hideLoading()
                        }
                    })
                    
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
