//
//  Stocks.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation
import CoreData
@objc(Stocks)
class Stocks: NSManagedObject {

    @NSManaged var stockid: String
    @NSManaged var name: String
    @NSManaged var low: String
    @NSManaged var high: String
    @NSManaged var current: String

}
