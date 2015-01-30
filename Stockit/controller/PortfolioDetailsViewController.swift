//
//  PortfolioDetailsViewController.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 31/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit



class PortfolioDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,AddStockViewControllerDelegate
{
    
    @IBOutlet weak var stockdetailview: UIView!
    @IBOutlet weak var stocktitlelabel: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addStockButton: UIButton!
    var stocks:[Stock] = [Stock]()
    var detailforportfolio:String!
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if(detailforportfolio != nil)
        {
            self.tableView.reloadData();
            self.stockdetailview.hidden=false;
        }
        else
        {
            var portfolios = CoreDataOps().getAllPortfolios()
            if portfolios.count > 0  {
                
                var stks = CoreDataOps().getAllStocksForPortfolio(portfolios[0].portfolioId)
                detailforportfolio = portfolios[0].portfolioId
                stocks.removeAll()
                if stks.count > 0 {
                    stockdetailview.hidden = false
                    for i in stks {
                        stocks.append(i)
                    }
                }
            }

        }
        if stocks.count < 1{
            CommonFunc.showAlert("No Stocks", message: "No stocks for this portfolio")
        }
        // Do any additional setup after loading the view.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if(stocks.count>0)
        {return 1;}
        else
        {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(stocks.count>0)
        {return stocks.count;}
        else
        {
        return 0;
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("stockCell", forIndexPath: indexPath) as StockTableViewCell
        cell.stockSymbolLabel.text = stocks[indexPath.row].name;
        cell.stockExchLabel.text=stocks[indexPath.row].exchange;
        cell.stockPriceLabel.text=stocks[indexPath.row].current;
        cell.stockSymbolLabel.sizeToFit()
        cell.stockExchLabel.sizeToFit()
        cell.stockPriceLabel.sizeToFit()
        return cell
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="AddStock"){
            var Details = segue.destinationViewController as AddStockViewController
            Details.portfolio = detailforportfolio
            Details.delegate = self;
        }
        else if segue.identifier == "stockDataSegue"{
            var stockDataVC = segue.destinationViewController as StockDetailsViewController
            var selectedRow = self.tableView.indexPathForSelectedRow()!.row
            stockDataVC.stockId = stocks[selectedRow].stockId
            
        }

    }
    func refreshStocks(yes: Bool) {
        var stks = CoreDataOps().getAllStocksForPortfolio(detailforportfolio)
        stocks.removeAll()
        if stks.count > 0 {
            stockdetailview.hidden = false
            for i in stks {
                stocks.append(i)
            }
        }
        tableView.reloadData()

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
