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
        var stocks = CommonFunc._readLocalJson("stock") as NSArray
        callback(stocks)
    }

    
    func getportfolios(callback:(NSArray) -> ()){
        var portfolios = CommonFunc._readLocalJson("portfolios") as NSArray
        callback(portfolios)
    }
    
//    func request(url:String, callback:(NSArray)-> ()){
//        
//    }
//    
//    func requestp(url:String, callback:(NSArray)-> ()){
//        
//    }
    
}