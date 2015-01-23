//
//  StockHistory.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 23/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import Foundation
import CoreData
@objc(StockHistory)
class StockHistory: NSManagedObject {
    
    @NSManaged var stockId: String
    @NSManaged var stockData: String
}
