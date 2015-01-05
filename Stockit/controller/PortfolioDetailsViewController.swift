//
//  PortfolioDetailsViewController.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 31/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

protocol PortfolioDetailsDelegate: class {
    func loadPortfolioDetails()
}

class PortfolioDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PortfolioDetailsDelegate {
    
    @IBOutlet var stocksTableView: UITableView!
    @IBOutlet var addStockButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var portfolioTableVC:PortfoliosTableViewController = PortfoliosTableViewController()
        portfolioTableVC.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.stocksTableView.dequeueReusableCellWithIdentifier("stockCell", forIndexPath: indexPath) as StockTableViewCell
        cell.stockSymbolLabel.text = "Goog"
        return cell
        
    }
    
    func loadPortfolioDetails() {
        println("delegating")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
