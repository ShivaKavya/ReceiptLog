//
//  Groups.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import RealmSwift

class Groups: Object {
    
    
    @objc dynamic var groups: String = ""
    let rDetails = List<Receipts>()
   
    override class func primaryKey() -> String {
        
        return "groups"
        
    }
    
    
   
    
}
