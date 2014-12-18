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
var stocks:NSArray=NSArray();
var portfolios:NSArray=NSArray();
func fetchFromJson() -> NSArray
{
        GetStocks().getstocks(){
            
            (stocks) in
            self.getstocks(stocks);
        }
    GetStocks().getportfolios(){
        
        (portfolios) in
        self.getportfolios(portfolios);
    }
        return []
        
        
}
func getstocks(data:NSArray)
{
        //println(data)
        self.stocks = data
        setstocks()
}
func getportfolios(data:NSArray)
{
        //println(data)
        self.portfolios = data
        setportfolios()
}
func setstocks()
{  let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var freq=NSFetchRequest(entityName: "Stocks")
    let manageContext = appDelegate.managedObjectContext!
    var mylist = manageContext.executeFetchRequest(freq, error: nil)!
    println(mylist.count)
    if(mylist.count<self.stocks.count)
    {
    var i=0;
    for i in 0...(self.stocks.count-1)
    {
        println(self.stocks[i])
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    let managedContext = appDelegate.managedObjectContext!
    let entity =  NSEntityDescription.entityForName("Stocks",inManagedObjectContext:managedContext)
    let newstock=Stocks(entity:entity!, insertIntoManagedObjectContext: managedContext) 
    newstock.stockid = self.stocks[i].valueForKey("stockid") as String
    newstock.name = self.stocks[i].valueForKey("name") as String
    newstock.low = self.stocks[i].valueForKey("lowest") as String
    newstock.high = self.stocks[i].valueForKey("highest") as String
    newstock.current = self.stocks[i].valueForKey("current") as String
    var error: NSError?
    if !managedContext.save(&error) {
        println("Could not save \(error), \(error?.userInfo)")
    }
    }
    }

}
func setportfolios()
{   var i=0;
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var freq=NSFetchRequest(entityName: "Portfilios")
    let manageContext = appDelegate.managedObjectContext!
    var mylist = manageContext.executeFetchRequest(freq, error: nil)!
    println(mylist.count)
    if(mylist.count<self.portfolios.count)
    {
        for i in 0...(self.portfolios.count-1)
        {
            //println(self.portfolios[i])
          
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                let managedContext = appDelegate.managedObjectContext!
                let entity =  NSEntityDescription.entityForName("Portfilios",inManagedObjectContext:managedContext)
                let newportfolio = Portfilios(entity:entity!, insertIntoManagedObjectContext: managedContext)
            newportfolio.portfolioId = self.portfolios[i].valueForKey("id") as String
            var stock = self.portfolios[i].valueForKey("stocks") as NSArray
            //println(stock)
            var j=0;
            var stockarray:[String]=[String]();
            for j in 0...(stock.count-1)
            {  stockarray.append(stock[j].valueForKey("id") as String);
            }
            //println(stockarray)
            var Data:NSData = NSKeyedArchiver.archivedDataWithRootObject(stockarray) as NSData
            newportfolio.stocks = Data;
             println(newportfolio.valueForKey("stocks"))
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
            }
        }
   
    
}
}


