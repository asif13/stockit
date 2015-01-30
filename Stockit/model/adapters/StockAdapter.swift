//
//  StockAdapter.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData

class StockAdapter :BaseAdapter {
    func addStock() -> Stock{
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescripition = NSEntityDescription.entityForName("Stock", inManagedObjectContext: managedObjectContext!)
        let stock = Stock(entity:entityDescripition!, insertIntoManagedObjectContext:managedObjectContext!)
        return stock
    }
    
    func insertStock() {
        save()
    }
    
    func getStockDetail(id: String!) -> Stock! {
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Stock")
        
        let predicate_id:NSPredicate = NSPredicate(format: "stockId = %@", id)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([predicate_id])
        
        fetchRequest.predicate = compound
        var syncDatas = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as NSArray?
        
        if syncDatas?.count > 0 {
            return syncDatas?.lastObject as Stock
        }
        return nil
    }
    
    func getAllStocks() -> [Stock]! {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Stock")
        
        var stock = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as [Stock]?
        
        if stock?.count > 0 {
            return stock
        }
        return nil
    
    }
    
    func cleanStockTable() {
        var allStock:[Stock]! = self.getAllStocks()
        
        if  allStock != nil {
            
            let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
            
            for (index, stock) in enumerate(allStock) {
                managedObjectContext?.deleteObject(stock)
            }
            save()
        }
    
    }
}
