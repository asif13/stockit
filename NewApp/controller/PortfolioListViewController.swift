//
//  ViewController.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit
import CoreData
class PortfolioListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var listViewTitleLabel: UILabel!
    @IBOutlet weak var tabletopbutton: UIButton!
    @IBOutlet weak var tabletop: UIView!
    @IBOutlet weak var ibtableview: UITableView!
    
    
    var displayData:[String] = [String]()
    
    var response = Dictionary<String,[String]>()
    
    var mystocks:[Stock] = [Stock]()
    var selectedIndex:Int=Int()
    var myPortfolios:[Portfolio] = [Portfolio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tabletopbutton.hidden = true;
        listViewTitleLabel.text = "Portfolios"
        self.myPortfolios = CoreDataOps().getAllPortfolios()
        
        if self.myPortfolios.count < 1 {
            CoreDataOps().addPortfolio("First Portfolio")
            var stockId = "Goog"
            var name = "Google"
            var low = "$223.54"
            var high = "$230"
            var current = "$228.45"
            CoreDataOps().addStockToPortfolio("First Portfolio", stockId: stockId, name: name, low: low, high: high, current: current)
        }
        self.loadDisplayData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = ibtableview.dequeueReusableCellWithIdentifier("icell", forIndexPath: indexPath) as TableViewCell
        cell.lable.text = toString((displayData[indexPath.row]))
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(listViewTitleLabel.text=="Portfolios"){
            selectedIndex = indexPath.row
            self.listViewTitleLabel.text = "Stocks"
            self.loadDisplayData()
        }
            
        else{
            var detailcontroller:StockDetailsViewController = StockDetailsViewController()
            detailcontroller.lable = "Hello";
            detailcontroller.modalPresentationStyle = UIModalPresentationStyle.PageSheet;
            self.presentViewController(detailcontroller, animated: true, completion: nil)
        }
    }
    
    
    func loadDisplayData(){
        if listViewTitleLabel.text == "Portfolios" {
            displayData.removeAll()
            var folios = CoreDataOps().getAllPortfolios() as [Portfolio]
            for i in folios {
                displayData.append(i.portfolioId)
            }
        }
        else if listViewTitleLabel.text == "Stocks" {
            var stks = CoreDataOps().getAllStocksForPortfolio(displayData[self.selectedIndex])
            if stks.count > 0 {
                displayData.removeAll()
            }
        }
        
        println(self.displayData)
        self.ibtableview.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier=="Details"){
            println("hello");
            var Details = segue.destinationViewController as StockDetailsViewController
            var mycell:TableViewCell=sender as TableViewCell
            Details.lable = mycell.lable.text!
        }
    }
    
    @IBAction func refreshBack(sender: AnyObject) {
        
    }
    
    
    @IBAction func addportfolio(sender: AnyObject) {
        println("hello")
        
    }
    
    
    
    
}

