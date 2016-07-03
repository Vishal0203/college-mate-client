//
//  HttpHelper.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpHelper: NSObject {
    enum Router: URLRequestConvertible {
        static let baseURLString = "http://139.59.4.205/api/v1_0"
        
        case whoami([String: String])
        case token_refresh()
        
        var method: Alamofire.Method {
            switch self {
            case .whoami, .token_refresh:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .whoami:
                return "/whoami"
            case .token_refresh:
                return "/refresh"
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if let token = prefs.stringForKey("todevs_token") {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            
            switch self {
            case .whoami(let parameters):
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
            default:
                return mutableURLRequest
            }
        }
    }
    
    class func errorHandler(error: Response<AnyObject, NSError>) -> Bool {
        var performSegue = false
        if let status = error.response?.statusCode {
            if status == 401 {
                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                if prefs.stringForKey("todevs_token") != nil {
                    
                    Alamofire.request(Router.token_refresh())
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                            case .Success:
                                if let auth_header = response.response?.allHeaderFields["Authorization"] as? String {
                                    let auth_token = auth_header.stringByReplacingOccurrencesOfString("Bearer ", withString: "")
                                    
                                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                                    prefs.setObject(auth_token, forKey: "todevs_token")
                                }
                            case .Failure:
                                performSegue = true
                            }
                        }
                    
                } else {
                    print(error)
                }
            }
        }
        
        return performSegue
    }
    
}