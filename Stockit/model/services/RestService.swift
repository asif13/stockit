//
//  GetResourceService.swift
//  project
//
//  Created by Administrator on 29/09/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import Foundation


class RestService{
    
    func getStockList(stock:String)->NSArray{
        
        var urlString:String = Constants.STOCK_SEARCH.stringByReplacingOccurrencesOfString("query=goog",withString: "query=\(stock)")
        var url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        var response: NSURLResponse?
        var error : NSError?
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        var resstr = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        var str = String(resstr!).stringByReplacingOccurrencesOfString("YAHOO.Finance.SymbolSuggest.ssCallback(",withString: "")
        str = str.stringByReplacingOccurrencesOfString(")", withString: "")
        var dt = str.dataUsingEncoding(NSUTF8StringEncoding)
        var err:NSError?
        var js = NSJSONSerialization.JSONObjectWithData(dt!, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
        var js1 = js["ResultSet"] as NSDictionary
        return js1["Result"] as NSArray
    }
    
}