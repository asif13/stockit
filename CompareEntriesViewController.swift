//
//  CompareEntriesViewController.swift
//  Stockit
//
//  Created by Venkatesh on 28/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import UIKit

class CompareEntriesViewController: UIViewController,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var comparebutton: UIButton!
    @IBOutlet weak var portfolio1: UITableView!
    
    @IBOutlet weak var portfolio2: UITableView!
    @IBOutlet weak var portfolio2searchbar: UISearchBar!
    var type:String = String()
@IBOutlet weak var portfolioSearchBar: UISearchBar!
 var displayporfolioList = [String]()
    var portfolios = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        println(type)
        if(type=="Portfolios")
        {
            portfolioSearchBar.placeholder="First Portfolio"
            portfolio2searchbar.placeholder="Second Portfolio"
            var stockList = CoreDataOps().getAllPortfolios()
            for stock in stockList {
                println(stock)
                portfolios.append(stock.portfolioId)
            }
            displayporfolioList = portfolios
        }
        else
        {
            portfolioSearchBar.placeholder="First Stock"
            portfolio2searchbar.placeholder="Second stock"
            var stockAdapter = CommonFunc.sharedInstanceStock
            var stockList = stockAdapter.getAllStocks()
            for stock in stockList {
                println(stock)
                portfolios.append(stock.name)
            }
            displayporfolioList = portfolios
        }
        
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
        println(displayporfolioList.count)
        return displayporfolioList.count
    }
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        if(tableView.description=="portfolio1")
        {
        let cell: comparefirstTableViewCell = portfolio1.dequeueReusableCellWithIdentifier("portfolio1") as comparefirstTableViewCell
        println(displayporfolioList[indexPath.row])
        cell.label.text = displayporfolioList[indexPath.row]
        return cell
        }
        else
        {
            let cell:comparesecondTableViewCell = portfolio2.dequeueReusableCellWithIdentifier("portfolio2") as comparesecondTableViewCell
            println(displayporfolioList[indexPath.row])
            cell.label.text = displayporfolioList[indexPath.row]
            return cell

        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
          if(tableView.tag==1)
          {
            println("Hello")
        portfolioSearchBar.text = displayporfolioList[indexPath.row]
        }
        else  if(tableView.tag==2)
          {
            portfolio2searchbar.text = displayporfolioList[indexPath.row]
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if CommonFunc.checkReachability() == false{
            CommonFunc.showAlert("No Internet", message: "Get Internet")
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        if(searchBar.tag==1)
        {println("hello2")
        if countElements(searchText) == 0 {
           displayporfolioList.removeAll()
            displayporfolioList = portfolios
        }
            
        else{
                    displayporfolioList.removeAll()
            for var i = 0; i < portfolios.count; i++ {
                let myRegex = searchText
                if let match = portfolios[i].rangeOfString(myRegex, options: .RegularExpressionSearch){
                    displayporfolioList.append(portfolios[i])
                }
            }
        }
            portfolio1.reloadData()

        }
        else if (searchBar.tag==2)
        {
            if countElements(searchText) == 0 {
                displayporfolioList.removeAll()
                displayporfolioList = portfolios
            }
                
            else{
                displayporfolioList.removeAll()
                for var i = 0; i < portfolios.count; i++ {
                    let myRegex = searchText
                    if let match = portfolios[i].rangeOfString(myRegex, options: .RegularExpressionSearch){
                        displayporfolioList.append(portfolios[i])
                    }
                }
            }
            portfolio2.reloadData();
        }
        
        
    }
    
    @IBAction func compare(sender: AnyObject) {
        if(portfolioSearchBar.text != portfolio2searchbar.text){
            self.performSegueWithIdentifier("compare", sender: sender)

            }
            else{
            CommonFunc.showAlert("Cannot Compare", message: "Select Two different \(type) to Compare")

            }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
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
