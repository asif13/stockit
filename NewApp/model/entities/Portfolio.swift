//
//  Portfolio.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation
import CoreData
@objc(Portfolio)
class Portfolio: NSManagedObject {
    
    @NSManaged var portfolioId: String
    @NSManaged var stocks: NSData
    
}
