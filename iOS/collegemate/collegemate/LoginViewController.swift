//
//  LoginViewController.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginPress(sender: AnyObject) {
        
        let credentials = [
            "email": self.username.text! as String,
            "password": self.password.text! as String
        ]
        
        performLogin(credentials)
    }
    
    func performLogin(user_creds: [String : AnyObject]) -> Void {
        Alamofire.request(.POST, "http://139.59.4.205/api/v1_0/login", parameters: user_creds)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let response = response.result.value {
                        let user_info = JSON(response)["user"].rawString()
                        
                        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setObject(user_info, forKey: "user_info")
                        prefs.synchronize()
                        
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                case .Failure:
                    HttpHelper.errorHandler(response)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.cornerRadius = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "loginSuccess" == segue.identifier {
            
        }
    }
}
