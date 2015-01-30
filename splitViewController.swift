//
//  splitViewController.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 24/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import UIKit

class splitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            var storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            var pieVC:CompareTableViewController = storyboard.instantiateViewControllerWithIdentifier("comparetable") as CompareTableViewController
            pieVC.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            pieVC.preferredContentSize = CGSizeMake(400.0, 250.0)
            presentViewController(pieVC, animated: true, completion: nil)
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
