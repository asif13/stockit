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
func fetchFromJson() -> NSArray
{
        GetStocks().getstocks(){
            
            (stocks) in
            self.getstocks(stocks);
        }
        return []
        
        
}
func getstocks(data:NSArray)
{
        //println(data)
        self.stocks = data
        setstocks()
}

func setstocks()
{   var i=0;
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


