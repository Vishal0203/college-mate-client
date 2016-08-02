//
//  SideMenuController.swift
//  collegemate
//
//  Created by Vishal Sharma on 09/07/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit
import Alamofire


class SideMenuController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var selectedInstitute: UITextView!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func onLogoutClick(sender: UIButton) {
        Alamofire.request(HttpHelper.Router.logout())
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(nil, forKey: "user_info")
                    prefs.synchronize()
                    
                    self.performSegueWithIdentifier("logoutSuccess", sender: self)
                case .Failure:
                    HttpHelper.errorHandler(response)
                }
        }
    }
    
    let allOptions = [
        ("Notifications", "m_notis"),
        ("Manage Institutes", "m_institutes"),
        ("Manage Staff", "m_staff"),
        ("Manage Members", "m_members")
    ]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("navOptions", forIndexPath: indexPath) as! SideMenuCustomCell
        
        let (navOption, image) = allOptions[indexPath.row]
        cell.navicon.image = UIImage(named: image)
        cell.navLabel.text = navOption
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        cell.selectedBackgroundView = bgColorView

        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        self.profilePic.clipsToBounds = true
        self.profilePic.layer.borderWidth = 8.0
        self.profilePic.layer.borderColor = UIColor(red:0.26, green:0.31, blue:0.38, alpha:1.0).CGColor
        
        self.logoutButton.backgroundColor = UIColor.clearColor()
        self.logoutButton.layer.cornerRadius = 5
        self.logoutButton.layer.borderWidth = 1
        self.logoutButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}
