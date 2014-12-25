//
//  SCParseJson.swift
//  SalesConnect
//
//  Created by Bishwadeep on 12/09/14.
//  Copyright (c) 2014 Bishwa. All rights reserved.
//

import UIKit
import CoreData
class ParseJson {
    
    
    var stocks:NSArray = NSArray()
    var portfolios:NSArray = NSArray()
    let stockAdapter = CommonFunc.sharedInstanceStock
    let portfolioAdapter = CommonFunc.sharedInstancePortfolio
    
    func fetchFromJson() -> NSArray {
        
        GetStocks().getstocks() {
            
            (stocks) in
            self.setStocksArray(stocks);
        }
        
        GetStocks().getportfolios() {
            
            (portfolios) in
            self.setPortfoliosArray(portfolios);
        }
            return []
    }
    
    
    func setStocksArray(data:NSArray) {
        //println(data)
        self.stocks = data
        setstocks()
    }
    
    
    func setPortfoliosArray(data:NSArray) {
        //println(data)
        self.portfolios = data
        setportfolios()
    }
    
    func setstocks() {
        var newstock = stockAdapter.addStock()
        
        for i in 0...(self.stocks.count-1) {
            newstock.stockId = self.stocks[i].valueForKey("stockId") as String
            newstock.name = self.stocks[i].valueForKey("name") as String
            newstock.low = self.stocks[i].valueForKey("lowest") as String
            newstock.high = self.stocks[i].valueForKey("highest") as String
            newstock.current = self.stocks[i].valueForKey("current") as String
            stockAdapter.insertStock()
        }
    }
    
    
    func setportfolios() {
        
        var i=0;
        var mylist = portfolioAdapter.getAllPortfolios()
//        println(mylist.count)
//        
//        
//        if(mylist.count<self.portfolios.count) {
//            
//            for i in 0...(self.portfolios.count-1) {
//                
//                var newportfolio = portfolioAdapter.addPortfolio()
//                newportfolio.portfolioId = self.portfolios[i].valueForKey("portfolioId") as String
//                var stock = self.portfolios[i].valueForKey("stocks") as NSArray
//
//                var stockarray:[String] = [String]()
//                for j in 0...(stock.count-1){
//                    stockarray.append(stock[j].valueForKey("id") as String);
//                }
//                
//                
//                
//            }
//        }
    }
}


