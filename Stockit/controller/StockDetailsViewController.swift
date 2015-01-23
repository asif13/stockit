//
//  DetailViewController.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

class StockDetailsViewController: UIViewController, LineGraphDataSource {
    var lable=""
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var navigation: UINavigationItem!
    var stockId:String?
    var stockHistoryAdapter = CommonFunc.sharedInstanceStockHistory
    override func viewDidLoad() {
        super.viewDidLoad()
//        var onClickBehind = UITapGestureRecognizer(target: self, action: "tapBehind:")
//        onClickBehind.numberOfTapsRequired = 1
//        onClickBehind.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(onClickBehind)
        
        var stockHistData : StockHistory?  = stockHistoryAdapter.getStockDetail(stockId!)
        var stockP: Array<CGFloat> = []
        var stockPrices : [Array<CGFloat>] = []
        var xaxislabel : [String] = []
        var yaxislabel: [String] = []
        if stockHistData == nil {
            var stockData = RestService().getStockData(stockId!)
            for i in stockData["cost"]!{
                var j = CGFloat((i as NSString).floatValue)
                stockP.append(j)
            }
            stockPrices.append(stockP)
            xaxislabel = stockData["cost"]!
            yaxislabel = stockData["date"]!
            
            
        }
        
        else{
            var stockP: Array<CGFloat> = []
            var stockData = CSV(csvData: (stockHistData?.stockData)!, error: nil)
            var stockDict = ["cost":(stockData?.columns["Adj Close"])!, "date":(stockData?.columns["Date"])!]
            for i in stockDict["cost"]!{
                var j = CGFloat((i as NSString).floatValue)
                stockP.append(j)
            }
            stockPrices.append(stockP)
            xaxislabel = stockDict["cost"]!
            yaxislabel = stockDict["date"]!
        }
        
        var bounds = CGRect(x: 40, y: 40, width: 700, height: 600)
        var lineGraph = LineGraph(frame: bounds)
        lineGraph.dataSource = self
        lineGraph.initLineGraph(stockPrices, xAxislabelArray: xaxislabel, yAxislabelArray: yaxislabel, gridVisible: true)
        lineGraph.displayLineGraph()
        self.view.addSubview(lineGraph)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true , completion: nil)
        
    }
    
//    @IBAction func tapBehind(sender:AnyObject){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismisscontroller(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
