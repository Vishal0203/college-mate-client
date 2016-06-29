//
//  LoginViewController.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func loginPress(sender: AnyObject) {
        
        let parameters = [
            "email": self.username.text! as String,
            "password": self.password.text! as String
        ]
        
        Alamofire.request(.POST, "http://139.59.4.205/api/v1_0/login", parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON["token"])
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
