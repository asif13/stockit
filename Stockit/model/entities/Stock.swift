//
//  Stock.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation
import CoreData
@objc(Stock)
class Stock: NSManagedObject {
    
    @NSManaged var stockId: String
    @NSManaged var name: String
    @NSManaged var low: String
    @NSManaged var high: String
    @NSManaged var current: String
    @NSManaged var exchange: String
    @NSManaged var portfolio: Portfolio
    
}