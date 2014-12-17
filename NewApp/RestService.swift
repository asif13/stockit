//
//  GetResourceService.swift
//  project
//
//  Created by Administrator on 29/09/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation


class GetStocks{
    func getstocks(callback:(NSArray) -> ()){
        request("/Users/adminidstrator/Desktop/NewApp/NewApp/stock.json", callback)
    }

    func request(url:String, callback:(NSArray)-> ()){
            let jsonData:NSData = NSData.dataWithContentsOfMappedFile(url) as NSData
            var err: NSError?
            var response = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
            callback(response)
       
    }
    func getportfolios(callback:(NSArray) -> ()){
        requestp("/Users/adminidstrator/Desktop/NewApp/NewApp/portfolios.json", callback)
    }
    func requestp(url:String, callback:(NSArray)-> ()){
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(url) as NSData
        var err: NSError?
        var response = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
        callback(response)
        
    }
    
}