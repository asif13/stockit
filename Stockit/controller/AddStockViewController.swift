//
//  AddStockViewController.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class stockData{
    var name:String
    var exch:String
    
    init(name:String, exch:String){
        self.name = name
        self.exch = exch
    }
}

class AddStockViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    @IBOutlet var stockSearchBar: UISearchBar!
    @IBOutlet var stockListTableView: UITableView!
    
    var displayStockList = [stockData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        var onClickBehind = UITapGestureRecognizer(target: self, action: "tapBehind:")
        onClickBehind.numberOfTapsRequired = 1
        onClickBehind.cancelsTouchesInView = false
        self.view.addGestureRecognizer(onClickBehind)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return displayStockList.count
    }
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: StockSearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("stockSearch") as StockSearchTableViewCell
        
        cell.stockNameLabel.text = displayStockList[indexPath.row].name
        cell.stockExchLabel.text = displayStockList[indexPath.row].exch
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var stockId = displayStockList[indexPath.row].name
        var name = displayStockList[indexPath.row].name
        var low = "$223.54"
        var high = "$230"
        var current = "$228.45"
        var exchange = displayStockList[indexPath.row].exch
        CoreDataOps().addStockToPortfolio("First Portfolio", stockId: stockId, name: name, low: low, high: high, current: current, exchange: exchange)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if CommonFunc.checkReachability() == false{
            CommonFunc.showAlert("No Internet", message: "Get Internet")
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        if countElements(searchText) == 0 {
            displayStockList.removeAll()
            var stockList = RestService().getStockList("Goog")
            for stock in stockList {
                var stk = stock as NSDictionary
                var stockName = stk["name"] as String
                var stockExch = stk["exch"] as String
                displayStockList.append(stockData(name: stockName, exch: stockExch))
            }
        }
            
        else{
            displayStockList.removeAll()
            var stockList = RestService().getStockList(searchText)
            for stock in stockList {
                var stk = stock as NSDictionary
                var stockName = stk["name"] as String
                var stockExch = stk["exch"] as String
                displayStockList.append(stockData(name: stockName, exch: stockExch))
            }
        }
        stockListTableView.reloadData()
        
        
    }
    
    @IBAction func tapBehind(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
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
