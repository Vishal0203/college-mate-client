//
//  HomeViewController.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            navMenu.target = self.revealViewController()
            navMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let token = prefs.stringForKey("todevs_token") {
            print(token)
            if let user_info = prefs.stringForKey("user_info") {
                print(user_info)
            }
        } else {
            self.performSegueWithIdentifier("requiresLogin", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
