//
//  CoreDataOps.swift
//  NewApp
//
//  Created by Nitesh on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData

class CoreDataOps {
    
    
    var stocks:NSArray = NSArray()
    var portfolios:NSArray = NSArray()
    let stockAdapter = CommonFunc.sharedInstanceStock
    let portfolioAdapter = CommonFunc.sharedInstancePortfolio
    let stockHistoryAdapter = CommonFunc.sharedInstanceStockHistory
    
    
    func addPortfolio(name:String) {
        var newPortfolio = portfolioAdapter.addPortfolio()
        newPortfolio.portfolioId = name
        portfolioAdapter.insertPortfolio()
    }
    
    func addStockToPortfolio(portfolioName:String, stockId:String, name:String, low:String, high:String, current:String, exchange:String){
        
        var newStock = stockAdapter.addStock()
        newStock.stockId = stockId
        newStock.name = name
        newStock.low = low
        newStock.high = high
        newStock.current = current
        newStock.exchange=exchange
        var portfolio = portfolioAdapter.getPortfolioDetail(portfolioName)
        newStock.portfolio = portfolio
        stockAdapter.insertStock()
    }
    
    func getAllStocksForPortfolio(portfolioName:String) -> [Stock] {
    
        var stockArray = [Stock]()
        var portfolio = portfolioAdapter.getPortfolioDetail(portfolioName)
        if portfolio != nil {
            for i in portfolio.stocks{
                stockArray.append(i as Stock)
            }
            return stockArray
        }
        
        return []
    }
    
    func getAllPortfolios() -> [Portfolio] {
        
        var portfolio = portfolioAdapter.getAllPortfolios()
        
        if portfolio != nil {
            return portfolio
        }
        return []
    }
    
    func addStockHistory(stockId:String, stockHistory:String){
        
        var newStock = stockHistoryAdapter.addStock()
        newStock.stockId = stockId
        newStock.stockData = stockHistory
        stockAdapter.insertStock()
    }
}


