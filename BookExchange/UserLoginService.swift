//
//  AllInterestService.swift
//  Chirag
//
//  Created by Chirag patel on 17/03/16.
//  Copyright © 2016 iOS Developer. All rights reserved.
//
/*
> 4. Get All Interests :-

>
*/
import UIKit
import Alamofire

class UserLoginService: NSObject, HTTPProtocol {
    
    
    func login(email: String, password: String, completion:  @escaping (_ response:AnyObject?, _ error: NSError?) -> ()) ->Void {
        let bodyParams = ["UserName":email, "PasswordHash":password]
        print(WebAPI.LoginUrl)
        print(bodyParams)
        executeWebService(method: .post, URLString: WebAPI.LoginUrl, parameters: bodyParams as [String : AnyObject]?, encoding: JSONEncoding.default, headers: nil, completion: completion)
    }
    func Register(userName: String, password: String, PhoneNumber: String, EmailAddress: String, completion:  @escaping (_ response:AnyObject?, _ error: NSError?) -> ()) ->Void {
        let bodyParams = ["UserName":userName, "PasswordHash":password, "PhoneNumber":PhoneNumber, "EmailAddress":EmailAddress]
       
        print(WebAPI.SingUpUrl)
        print(bodyParams)
        executeWebService(method: .post, URLString: WebAPI.SingUpUrl, parameters: bodyParams as [String : AnyObject]?, encoding: JSONEncoding.default, headers: nil, completion: completion)
    }
    
}

