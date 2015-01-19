//
//  AddStockViewController.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

protocol AddStockViewControllerDelegate:class
{    func refreshStocks(yes:Bool)
}
class AddStockViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate,UIGestureRecognizerDelegate {
    @IBOutlet var stockSearchBar: UISearchBar!
    @IBOutlet var stockListTableView: UITableView!
    var portfolio:String!
    var displayStockList = [stockData]()
    var delegate:AddStockViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
       
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
        println(displayStockList[indexPath.row].name)
        var low = "$223.54"
        var high = "$230"
        var current = "$228.45"
        var exchange = displayStockList[indexPath.row].exch
        println(portfolio)
        CoreDataOps().addStockToPortfolio(portfolio, stockId: stockId, name: name, low: low, high: high, current: current, exchange: exchange)
        self.dismissViewControllerAnimated(true , completion: { () -> Void in
            self.delegate?.refreshStocks(true)
            return
        })
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
    
//    @IBAction func tapBehind(sender:UITapGestureRecognizer){
//        if (sender.state == UIGestureRecognizerState.Ended)
//        {
//                
//            var location:CGPoint = sender.locationInView(nil) //Passing nil gives us coordinates in the window
//            println(location)
//            //Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
//           println((self.view.pointInside(self.view.convertPoint(location, fromView: self.view.window), withEvent: nil)))
//            if(!(self.view.pointInside(self.view.convertPoint(location, fromView: self.view.window), withEvent: nil)))
//            {   self.view.window?.removeGestureRecognizer(sender);
//                self.dismissViewControllerAnimated(true, completion: nil)
//
//            }
//           
//        }
//        
//    }
    @IBAction func dismiss(sender: AnyObject) {
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
