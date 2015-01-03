//
//  addportfolioViewController.swift
//  NewApp
//
//  Created by Venkatesh on 18/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

protocol AddPortfolioViewControllerDelegate: class {
    func refreshPortfolios(yes:Bool)
}

class AddPortfolioViewController: UIViewController {
    
    var delegate:AddPortfolioViewControllerDelegate?
    @IBOutlet var portfolioNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPortfolio(sender: AnyObject) {
        
        
        if portfolioNameTextField.text != ""{
            CoreDataOps().addPortfolio(portfolioNameTextField.text)
            self.dismissViewControllerAnimated(true , completion: { () -> Void in
                self.delegate?.refreshPortfolios(true)
                return
            })
        }
        else{
            self.dismissViewControllerAnimated(true , completion: { () -> Void in
                self.delegate?.refreshPortfolios(false)
                return
            })
        }
        
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
