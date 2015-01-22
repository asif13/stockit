//
//  DetailViewController.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

class StockDetailsViewController: UIViewController {
    var lable="";
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var navigation: UINavigationItem!
    var stockId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(stockId!)
//        var onClickBehind = UITapGestureRecognizer(target: self, action: "tapBehind:")
//        onClickBehind.numberOfTapsRequired = 1
//        onClickBehind.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(onClickBehind)
        
        var stockData = RestService().getStockData(stockId!)
        println(stockData)
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
