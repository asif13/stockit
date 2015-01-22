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
        
        var urlString:String = Constants.STOCK_SEARCH_URL.stringByReplacingOccurrencesOfString("query=goog",withString: "query=\(stock)")
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
    
    func getStockData(stockId:String) -> [String: [String]]{
        var urlString:String = Constants.STOCK_DATA_URL.stringByReplacingOccurrencesOfString("s=GOOG", withString: "s=\(stockId)")
        println(urlString)
        var url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        var response: NSURLResponse?
        var error : NSError?
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil)
        var resstr = NSString(data: data!, encoding: NSUTF8StringEncoding)
        var stockData = CSV(csvData: resstr!, error: nil)
        var stockDict = ["cost":(stockData?.columns["Adj Close"])!, "date":(stockData?.columns["Date"])!]
        return stockDict
        
        
    }
    
}