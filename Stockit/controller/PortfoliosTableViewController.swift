//
//  PortfoliosTableViewController.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 31/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit


class PortfoliosTableViewController: UITableViewController, AddPortfolioViewControllerDelegate{
    
    var displayData:[String] = [String]()
    var myPortfolios:[Portfolio] = [Portfolio]()
    var selectedIndex:Int=Int()
    var stocksForPortfolio:[Stock] = [Stock]()
    
    @IBOutlet var rightBarButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Portfolios"
        
        self.myPortfolios = CoreDataOps().getAllPortfolios()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTapCell:")
        doubleTapGesture.numberOfTapsRequired = 2
        
        self.tableView.addGestureRecognizer(doubleTapGesture)
        
        
        if self.myPortfolios.count < 1 {
            CoreDataOps().addPortfolio("First Portfolio")
        }
        self.loadDisplayData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.displayData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("icell", forIndexPath: indexPath) as PortfoliosTableViewCell
        cell.lable.text = toString((displayData[indexPath.row]))
        return cell

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         println("hello")
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func doubleTapCell(sender:AnyObject){
        
        if self.navigationItem.title=="Portfolios" {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshBack:"), animated: true)
            //tabletopbutton.hidden = false
            var tap : UITapGestureRecognizer = sender as UITapGestureRecognizer
            var point : CGPoint = tap.locationInView(self.tableView)
            var indx = self.tableView.indexPathForRowAtPoint(point)!
            self.selectedIndex = indx.row
            self.navigationItem.title = "Stocks"
            self.loadDisplayData()
        }
        else{
            
            var detailcontroller:StockDetailsViewController = StockDetailsViewController()
            detailcontroller.lable = "Hello"
            detailcontroller.modalPresentationStyle = UIModalPresentationStyle.PageSheet;
            self.presentViewController(detailcontroller, animated: true, completion: nil)
        }
        
    }
//    @IBAction func singleTapCell(sender:AnyObject){
//        
//        if self.navigationItem.title != "Portfolios" {
//            var detailcontroller:StockDetailsViewController = StockDetailsViewController()
//            detailcontroller.lable = "Hello"
//            detailcontroller.modalPresentationStyle = UIModalPresentationStyle.PageSheet;
//            self.presentViewController(detailcontroller, animated: true, completion: nil)
//        }
//        else{
//            self.delegate?.loadPortfolioDetails()
//        }
//        
//    }
    
    @IBAction func refreshBack(sender: AnyObject) {
        self.navigationItem.title = "Portfolios"
        //tabletopbutton.hidden = true
        self.loadDisplayData()
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @IBAction func addItemBarButton(sender: AnyObject) {
        
    }
    
    func loadDisplayData(){
        if self.navigationItem.title == "Portfolios" {
            displayData.removeAll()
            var folios = CoreDataOps().getAllPortfolios() as [Portfolio]
            for i in folios {
                displayData.append(i.portfolioId)
            }
        }
        else {
            var stks = CoreDataOps().getAllStocksForPortfolio(displayData[self.selectedIndex])
            self.navigationItem.title = displayData[self.selectedIndex]
            displayData.removeAll()
            if stks.count > 0 {
                for i in stks {
                    displayData.append(i.name)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier=="Details"){
            var Details = segue.destinationViewController as StockDetailsViewController
            var mycell:PortfoliosTableViewCell = sender as PortfoliosTableViewCell
            Details.lable = mycell.lable.text!
        }
            
            
        else if(segue.identifier == "presentAddPortfolio"){
            var addFolio : AddPortfolioViewController = AddPortfolioViewController()
            addFolio = segue.destinationViewController as AddPortfolioViewController
            addFolio.delegate = self
        }
        else if(segue.identifier == "showdetail")
        {   var selectedRow = self.tableView.indexPathForSelectedRow()!.row
            var PortfolioDetail : PortfolioDetailsViewController = PortfolioDetailsViewController()
            PortfolioDetail = segue.destinationViewController as PortfolioDetailsViewController
            var cell:PortfoliosTableViewCell = sender as PortfoliosTableViewCell;
            var stks = CoreDataOps().getAllStocksForPortfolio(cell.lable.text as String!)
            var stocks:[Stock] = [Stock]()
            stocks.removeAll()
            println(displayData[selectedRow])
            PortfolioDetail.detailforportfolio = displayData[selectedRow]
            if stks.count > 0 {
                for i in stks {
                    stocks.append(i)
                }
                
                println(stocks)
                PortfolioDetail.stocks = stocks
            }
        }
    }
    
    
    func refreshPortfolios(yes: Bool) {
        if yes {
            self.loadDisplayData()
        }
    }

}
