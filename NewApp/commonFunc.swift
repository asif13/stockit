//
//  commonFunc.swift
//  NewApp
//
//  Created by Nitesh on 18/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData
class CommonFunc: NSObject {

    class func _readLocalJson(fileName:String) -> AnyObject {
        var filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") as String?
        var raw:NSData? = NSData.dataWithContentsOfMappedFile(filePath!) as NSData?
        //        var raw:NSData = NSData.dataWithContentsOfFile(filePath!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
        var jsonData:AnyObject = NSJSONSerialization.JSONObjectWithData(raw!, options: NSJSONReadingOptions.MutableContainers, error: nil)!
        return jsonData
    }
    
}

