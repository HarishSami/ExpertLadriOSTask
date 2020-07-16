//
//  StorageService.swift
//  ExpertLadr_SystemTask
//
//  Created by Harish Sami on 16/07/20.
//  Copyright © 2020 Harish Sami. All rights reserved.

import Foundation
import CoreData
import UIKit

class StorageService {
    
    
    func saveUserDetails(userName: String, password: String)-> Bool {
        let encryptedPassword = Data(password.utf8).base64EncodedString()
        return  save(model: UserEntityModel(userName: userName, password: encryptedPassword))
    }
    
    @discardableResult
    func save(model: UserEntityModel)-> Bool {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        preconditionFailure("Unable to get Appdelegate")
      }
      let managedContext =
        appDelegate.persistentContainer.viewContext
      let entityDescription =
        NSEntityDescription.entity(forEntityName: "User",
                                   in: managedContext)!
      
       let entity = NSManagedObject(entity: entityDescription,
                                   insertInto: managedContext)
        entity.setValue(model.userName, forKeyPath: "userName")
        entity.setValue(model.password, forKeyPath: "password")
        if let _ = try? managedContext.save() {
            return true
        } else {
            return false
        }
    }
    
    
    func getModel(entityName: String) -> [UserEntityModel] {
        var allUserDetails: [UserEntityModel] = []
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Unable to get Appdelegate")
        }
        let managedContext =
          appDelegate.persistentContainer.viewContext
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let result = try? managedContext.fetch(fetchRequest) {
            allUserDetails = result.compactMap { getUserDetails(managedObject: $0) }
           return allUserDetails
        } else {
            return allUserDetails
        }
    }
    
    private func getUserDetails(managedObject: NSManagedObject) -> UserEntityModel? {
        guard let userName = managedObject.value(forKeyPath: "userName") as? String, let password = managedObject.value(forKeyPath: "password") as? String else {
            return nil
        }
        let passwordData: NSData = NSData(base64Encoded: password, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        let detailPassword = NSString(data: passwordData as Data, encoding: String.Encoding.utf8.rawValue)
 
        return UserEntityModel(userName: userName, password: detailPassword! as String)
    }
}

struct UserEntityModel {
    let userName: String
    let password: String
}
