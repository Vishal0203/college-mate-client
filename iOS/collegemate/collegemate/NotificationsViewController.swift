//
//  HomeViewController.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseInstanceID

class NotificationsViewController: UIViewController {

    
    @IBOutlet weak var navMenu: UIBarButtonItem!
    @IBOutlet var notif_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let user_info = prefs.stringForKey("user_info") {
            print(user_info)
        } else {
            self.performSegueWithIdentifier("requiresLogin", sender: self)
        }
        
        if self.revealViewController() != nil {
            navMenu.target = self.revealViewController()
            navMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.notif_view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            customizeSideMenu()
        }
    }
    
    
    func customizeSideMenu() -> Void {
        self.revealViewController().rearViewRevealWidth = 280.0
        self.revealViewController().rearViewRevealDisplacement = 80.0
        
        self.revealViewController().toggleAnimationType = SWRevealToggleAnimationType.Spring
        self.revealViewController().toggleAnimationDuration = 0.85
        
        self.revealViewController().frontViewShadowRadius = 10.0
        self.revealViewController().frontViewShadowOffset = CGSizeMake(0.0, 2.5)
        self.revealViewController().frontViewShadowOpacity = 0.8
        self.revealViewController().frontViewShadowColor = UIColor.darkGrayColor()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "requiresLogin" {
            segue.destinationViewController.navigationController?.setNavigationBarHidden(true, animated: false)
            segue.destinationViewController.hidesBottomBarWhenPushed = true
        }
    }
 
}
