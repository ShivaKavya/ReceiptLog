//
//  UserData.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import RealmSwift

class UserData: Object{
    
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var bankAccountNumber: String = ""
    @objc dynamic var profilepicture: NSData? = nil
    override class func primaryKey() -> String {
     
        return "firstName"
        
     }
   
}
