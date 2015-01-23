//
//  StockHistoryAdapter.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 23/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import UIKit
import CoreData

class StockHistoryAdapter :BaseAdapter {
    func addStock() -> StockHistory{
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescripition = NSEntityDescription.entityForName("StockHistory", inManagedObjectContext: managedObjectContext!)
        let stock = StockHistory(entity:entityDescripition!, insertIntoManagedObjectContext:managedObjectContext!)
        return stock
    }
    
    func insertStock() {
        save()
    }
    
    func getStockDetail(id: String!) -> StockHistory! {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "StockHistory")
        
        let predicate_id:NSPredicate = NSPredicate(format: "stockId = %@", id)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([predicate_id])
        
        fetchRequest.predicate = compound
        var syncDatas = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as NSArray?
        if syncDatas?.count > 0 {
            return syncDatas?.lastObject as StockHistory
        }
        return nil
    }
    
    func getAllStocks() -> [StockHistory]! {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "StockHistory")
        
        var stock = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as [StockHistory]?
        
        if stock?.count > 0 {
            return stock
        }
        return nil
        
    }
    
    func cleanStockTable() {
        var allStock:[StockHistory]! = self.getAllStocks()
        
        if  allStock != nil {
            
            let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
            
            for (index, stock) in enumerate(allStock) {
                managedObjectContext?.deleteObject(stock)
            }
            save()
        }
        
    }
}
