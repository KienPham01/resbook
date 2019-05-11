//
//  BaseTableViewController.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class BaseTableViewController<T, C: UITableViewCell>: UITableViewController {
    let data = [T]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: C.self), for: indexPath)
        
        return cell
    }
}
