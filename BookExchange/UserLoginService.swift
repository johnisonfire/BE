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
    func ProfileEdit(userName: String, FirstName: String, LastName: String , password: String, PhoneNumber: String, EmailAddress: String, completion:  @escaping (_ response:AnyObject?, _ error: NSError?) -> ()) ->Void {
        let bodyParams = ["UIdToChange":userName,"FirstName":FirstName,"LastName" : LastName, "PasswordHash":password, "PhoneNumber":PhoneNumber, "EmailAddress":EmailAddress]
        print(WebAPI.UpdateProfile)
        print(bodyParams)
        executeWebService(method: .post, URLString: WebAPI.UpdateProfile, parameters: bodyParams as [String : AnyObject]?, encoding: JSONEncoding.default, headers: nil, completion: completion)
    }
    func Addbook(userid: String, Name: String, Image: NSMutableArray, Author: String, Publisher
: String, Edition: String, ListPrice: String, Negotiable: String, Description: String, Condition: String, completion:  @escaping (_ response:AnyObject?, _ error: NSError?) -> ()) ->Void {
        print(Image)
        let bodyParams = ["UserId":userid,"Name":Name,"Image" : Image, "Author":Author, "Publisher":Publisher, "Edition":Edition, "ListPrice":ListPrice, "Negotiable":Negotiable, "Description":Description, "Condition":Condition] as [String : Any]
        print(WebAPI.NewListing)
        print(bodyParams)
        executeWebService(method: .post, URLString: WebAPI.NewListing, parameters: bodyParams as [String : AnyObject]?, encoding: JSONEncoding.default, headers: nil, completion: completion)
    }
    func Search(Key: String, Value: String, completion:  @escaping (_ response:AnyObject?, _ error: NSError?) -> ()) ->Void {
        let bodyParams = [Key:Value]
        executeWebService(method: .post, URLString: WebAPI.Search, parameters: bodyParams as [String : AnyObject]?, encoding: JSONEncoding.default, headers: nil, completion: completion)
    }
}


