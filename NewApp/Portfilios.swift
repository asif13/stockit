//
//  Portfilios.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation
import CoreData

class Portfilios: NSManagedObject {

    @NSManaged var portfolioId: String
    @NSManaged var stocks: NSData

}
