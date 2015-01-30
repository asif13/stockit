//
//  BaseAdapter.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

class BaseAdapter: NSObject {
    
    func save() {
        let appdelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        appdelegate.saveContext()
    }
    
}
