//
//  Receipts.swift
//  ReceiptLog
//
//  Created by Shiva Kavya on 2019-08-01.
//  Copyright © 2019 Shiva Kavya. All rights reserved.
//

import Foundation
import RealmSwift

class Receipts: Object {
    
    @objc dynamic var rName: String = ""
    @objc dynamic var rDescription: String = ""
    @objc dynamic var rDate: String = ""
    @objc dynamic var rAmount: String = ""
    @objc dynamic var receiptPicture: NSData? = nil
    
    var parentCategory = LinkingObjects(fromType: Groups.self, property: "rDetails")
    
    
}
