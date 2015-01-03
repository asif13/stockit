//
//  PortfolioAdapter.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 25/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData

class PortfolioAdapter :BaseAdapter {
    func addPortfolio() -> Portfolio{
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescripition = NSEntityDescription.entityForName("Portfolio", inManagedObjectContext: managedObjectContext!)
        let portfolio = Portfolio(entity:entityDescripition!, insertIntoManagedObjectContext:managedObjectContext!)
        return portfolio
    }
    
    func insertPortfolio() {
        save()
    }
    
    func getPortfolioDetail(id: String!) -> Portfolio! {
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Portfolio")
        let predicate_id:NSPredicate = NSPredicate(format: "portfolioId = %@", id)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([predicate_id])
        
        fetchRequest.predicate = compound
        var syncDatas = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as NSArray?
        
        if syncDatas?.count > 0 {
            return syncDatas?.lastObject as Portfolio
        }
        return nil
    }
    
    func getAllPortfolios() -> [Portfolio]! {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Portfolio")
        
        var portfolio = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as [Portfolio]?
        
        if portfolio?.count > 0 {
            return portfolio
        }
        return nil
        
    }
    
    func cleanPortfolioTable() {
        var allPortfolio:[Portfolio]! = self.getAllPortfolios()
        
        if  allPortfolio != nil {
            
            let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
            
            for (index, portfolio) in enumerate(allPortfolio) {
                managedObjectContext?.deleteObject(portfolio)
            }
            save()
        }
        
    }
}

