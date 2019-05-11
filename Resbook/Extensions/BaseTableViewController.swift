//
//  BaseTableViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class BaseTableViewController<D>: UITableViewController {
    var data: [D]!
    var onSelection: ((D) -> Void)?
    weak var popup: FHRPopupViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BaseCell")
        tableView.rowHeight = 95
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: Selector(("addMoreData")))
        self.title = D.self == Author.self ? ("Author") : ("Category")
    }
    
    init(data: [D]) {
        super.init(style: .plain)
        self.data = data
    }
    
    @objc func addMoreData() {
        let inserPopup = InsertDataViewController(type: D.self == Author.self ? (.author) : (.category))
        self.popup = FHRPopupViewController.create(self.parent!).show(inserPopup, .center)
        inserPopup.onClickCancel = {
            self.popup.dismiss()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
        if D.self == Author.self {
            cell.imageView?.loadImage(url: (data[indexPath.row] as! Author).avatar, placeHolderImage: #imageLiteral(resourceName: "user"))
            cell.textLabel?.text = (data[indexPath.row] as! Author).name
        } else {
            cell.imageView?.loadImage(url: (data[indexPath.row] as! Category).avatar, placeHolderImage: #imageLiteral(resourceName: "user"))
            cell.textLabel?.text = (data[indexPath.row] as! Category).name
        }
        cell.reloadInputViews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onSelection?(data[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
