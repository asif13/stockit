//
//  ViewController.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var stocktable: UITableView!
    @IBOutlet weak var ibtableview: UITableView!
    var arr=["one","two"];
    var stocks:NSArray = NSArray();
    var response:NSArray!
    var selectedIndex:Int=Int();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ParseJson().fetchFromJson()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var freq=NSFetchRequest(entityName: "Stocks")
        var mylist=managedContext.executeFetchRequest(freq, error: nil)!
        println(mylist)
        freq=NSFetchRequest(entityName: "Portfilios")
        var myPortfolios=managedContext.executeFetchRequest(freq, error: nil)!
        println(myPortfolios)
        var response = Dictionary<String,[String]>()
        var j=0;
        for j in 0...(myPortfolios.count-1)
        {   var stockarray:[String] = NSKeyedUnarchiver.unarchiveObjectWithData(myPortfolios[j].valueForKey("stocks")) as [String]
            response[myPortfolios[j].valueForKey("portfolioId") as String] = stockarray
        }
        stocktable.hidden=true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView==ibtableview){
        return arr.count
        }
        else
        {   if(stocks.count==0)
            {return 0;
            }else
        {return stocks.count}
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView==ibtableview){
        var cell = ibtableview.dequeueReusableCellWithIdentifier("icell", forIndexPath: indexPath) as TableViewCell
        
        
        
        cell.lable.text = toString((arr[indexPath.row]))
        
        return cell
        }
        else
        {
            var cell = stocktable.dequeueReusableCellWithIdentifier("stock", forIndexPath: indexPath) as staticTableViewCell
            
            
            println(stocks)
            cell.lable1.text = (stocks.objectAtIndex(indexPath.row).valueForKey("name")) as? String
            cell.lable2.text = (stocks.objectAtIndex(indexPath.row).valueForKey("lowest")) as? String
            cell.lable3.text = (stocks.objectAtIndex(indexPath.row).valueForKey("highest")) as? String
            cell.lable4.text = (stocks.objectAtIndex(indexPath.row).valueForKey("current")) as? String

            return cell
        }
    }
    
    func show()
    {var i=0;
        for i in 0...(response.count-1)
        {   if(response.objectAtIndex(i).valueForKey("id") as String == arr[selectedIndex])
            {   stocks = response.objectAtIndex(i).valueForKey("stocks") as NSArray
                stocktable.reloadData()
                stocktable.hidden=false;
            }
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView==ibtableview)
        {
            
        selectedIndex = indexPath.row
        return self.show()
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Desc")
        {
            var desc = segue.destinationViewController as DetailViewController
            var mycell:staticTableViewCell=sender as staticTableViewCell
            desc.lable=mycell.lable1.text!;

        }
    }
}

