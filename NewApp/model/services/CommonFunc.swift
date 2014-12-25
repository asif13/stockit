//
//  CommonFunc.swift
//  NewApp
//
//  Created by Nitesh on 18/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData
class CommonFunc: NSObject {
    
    
    //singleton class instance StockAdapter
    class var sharedInstanceStock : StockAdapter {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : StockAdapter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = StockAdapter()
        }
        return Static.instance!
    }
    
    //singleton class instance PortfolioAdapter
    class var sharedInstancePortfolio : PortfolioAdapter {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : PortfolioAdapter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PortfolioAdapter()
        }
        return Static.instance!
    }
    
    class func _readLocalJson(fileName:String) -> AnyObject {
        var filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") as String?
        var raw:NSData? = NSData.dataWithContentsOfMappedFile(filePath!) as NSData?
        //        var raw:NSData = NSData.dataWithContentsOfFile(filePath!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
        var jsonData:AnyObject = NSJSONSerialization.JSONObjectWithData(raw!, options: NSJSONReadingOptions.MutableContainers, error: nil)!
        return jsonData
    }
    
}

