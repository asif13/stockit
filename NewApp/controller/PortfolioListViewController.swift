//
//  ViewController.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData
class PortfolioListViewController: UIViewController,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tabletopbutton: UIButton!
    @IBOutlet weak var portfoliotitle: UILabel!
    @IBOutlet weak var tabletop: UIView!
    @IBOutlet weak var ibtableview: UITableView!
    var arr=["one","two"];
    var response = Dictionary<String,[String]>()
    var mystocks:[Stock] = [Stock]();
    var selectedIndex:Int=Int();
    var myPortfolios:NSArray=NSArray();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabletopbutton.hidden=true;
        ParseJson().fetchFromJson()
        portfoliotitle.text="Portfolios";
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var freq=NSFetchRequest(entityName: "Stock")
        var mystock=managedContext.executeFetchRequest(freq, error: nil)!
        mystocks = mystock as [Stock];
        freq=NSFetchRequest(entityName: "Portfolio")
        myPortfolios = managedContext.executeFetchRequest(freq, error: nil)!
        println(myPortfolios.count)
        var j=0;
        for var j=0; j<(myPortfolios.count); ++j {
            println(myPortfolios[j].valueForKey("portfolioId"))
            var stockarray:[String] = NSKeyedUnarchiver.unarchiveObjectWithData(myPortfolios[j].valueForKey("stocks") as NSData) as [String]
            response[myPortfolios[j].valueForKey("portfolioId") as String] = stockarray
        }
        println(response)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ibtableview.dequeueReusableCellWithIdentifier("icell", forIndexPath: indexPath) as TableViewCell
        
        
        
        cell.lable.text = toString((arr[indexPath.row]))
        return cell
        
    }
    
    func show()
    {   var j=0;
        var stockarray:[String] = response[arr[selectedIndex]]!
        println(arr[selectedIndex])
        portfoliotitle.text=arr[selectedIndex];
        arr.removeAll();
        for j in 0...(stockarray.count-1)
        {println(mystocks.count)
            var i=0;
            for i in 0...(mystocks.count-1)
            {       if(mystocks[i].valueForKey("stockid") as String == stockarray[j])
            {println(mystocks[i].valueForKey("stockid"))
                println(stockarray[j])
                var name:String = mystocks[i].valueForKey("name") as String
                arr.append(name)
                ibtableview.reloadData();
                }
            }
        }
        tabletopbutton.hidden=false;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(portfoliotitle.text=="Portfolios")
        {
            selectedIndex = indexPath.row
            return self.show()
        }
        else
        {   var detailcontroller:StockDetailsViewController = StockDetailsViewController()
            detailcontroller.lable = "Hello";
            detailcontroller.modalPresentationStyle = UIModalPresentationStyle.PageSheet;
            self.presentViewController(detailcontroller, animated: true, completion: nil)
        }
    }
    
    @IBAction func refreshBack(sender: AnyObject) {
        arr.removeAll()
        var i=0;
        for i in 0...(response.count-1)
        {   arr.append(myPortfolios[i].valueForKey("portfolioId") as String)
            ibtableview.reloadData()
        }
        portfoliotitle.text="Portfolios";
        tabletopbutton.hidden=true;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPortfolios.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell=collectionView.dequeueReusableCellWithReuseIdentifier("portfolio", forIndexPath: indexPath) as  PortfolioCollectionViewCell
        cell.portfoilititle.text = myPortfolios[indexPath.row].valueForKey("portfolioId") as? String
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    @IBAction func addportfolio(sender: AnyObject) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier=="Details")
        {
            println("hello");
            var Details = segue.destinationViewController as StockDetailsViewController
            var mycell:TableViewCell=sender as TableViewCell
            Details.lable = mycell.lable.text!
        }
    }
    
    
}

