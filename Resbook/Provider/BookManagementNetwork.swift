//
//  BookManagementNetwork.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import ObjectMapper
public typealias Completion = ((Bool, String?) -> Void)

extension Network {
    public static func submitBook(parameter: BookInformationParameter, parameterBookItem: BookItemParameter, completionHandler: @escaping Completion) {
        let databaseRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "/book_data/book_items_noa/").childByAutoId()
        
        let databaseBookRef = databaseRef.child("book/")
        let databaseBookItemRef = databaseRef.child("book_item/")
        
        databaseBookRef.updateChildValues(parameter.toJSON()) { (error, _) in
            if error != nil {
                completionHandler(false, error?.localizedDescription ?? "")
            } else {
                completionHandler(true, nil)
            }
        }
        
        databaseBookItemRef.updateChildValues(parameterBookItem.toJSON()) { (error, _) in
            if error != nil {
                completionHandler(false, error?.localizedDescription ?? "")
            } else {
                completionHandler(true, nil)
            }
        }
    }
    
    public static func getList<T: ImmutableMappable>(type: T.Type, completionHandler: @escaping (Bool, [T]?) -> Void) {
        
        let databaseRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "book_data").child((type  == Author.self) ? "authors" : "categories")
        
        databaseRef.observe(.value) { (snapshot) in
            if let dataJSON = snapshot.value as? [String: Any] {
                var result = [T]()
                for (key, value) in dataJSON {
                    
                    if var json = value as? [String: String] {
                        json["uid"] = key
                        let temp = try! Mapper<T>().map(JSON: json).self
                        result.append(temp)
                    }
                }
                completionHandler(true, result)
                
                databaseRef.removeAllObservers()
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    public static func addNewData<T: ImmutableMappable>(parameter: T, type: T.Type, completion: (Bool) -> Void) {
        let databaseRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "book_data").child((type == Author.self) ? "authors" : "categories").childByAutoId()
        
        let paramValue = parameter.toJSON()
        databaseRef.setValue(paramValue)
        
        completion(true)
        
        databaseRef.removeAllObservers()
    }
    
    public static func scannerQR(barcode: String, completionHandler: @escaping (Bool) -> Void) {
        let databaseRef = AppDelegate.sharedInstance.ref.database.reference(withPath: "book_data").child("barcode_tmp")
        
        databaseRef.observe(.value) { (snapshot) in
            if !snapshot.exists() {
                completionHandler(false)
            } else {
                let parameterValue = [barcode: DataServices.sharedInstance.userProfile?.user_id]
                databaseRef.setValue(parameterValue)
                completionHandler(true)
                
                databaseRef.removeAllObservers()
            }
        }
        
    }
}
