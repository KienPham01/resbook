//
//  CreateBookViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/7/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class CreateBookViewController: BaseViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var purchasePrice: UITextField!
    @IBOutlet weak var salePrice: UITextField!
    @IBOutlet weak var freeLoanButton: CheckBox!
    @IBOutlet weak var dayBorrow: UITextField!
    @IBOutlet weak var quantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
    }
    
    private func configurationUI() {
        
    }
}

