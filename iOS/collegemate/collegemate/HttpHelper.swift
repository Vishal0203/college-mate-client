//
//  HttpHelper.swift
//  collegemate
//
//  Created by Vishal Sharma on 29/06/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import Foundation
import Alamofire

class HttpHelper: NSObject {
    enum Router: URLRequestConvertible {
        static let baseURLString = "http://139.59.4.205/api/v1_0"
        
        case whoami([String: String])
        
        var method: Alamofire.Method {
            switch self {
            case .whoami:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .whoami:
                return "/whoami"
            }
        }
        
        // MARK: URLRequestConvertible
        
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
//            default:
//                return mutableURLRequest
            }
        }
    }
}