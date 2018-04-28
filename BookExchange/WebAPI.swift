//
//  WebAPI.swift
//
//
//  Created by Chirag Patel on 17/03/16.
//  Copyright © 2016 iOS Developer. All rights reserved.
//

import Foundation
class ABC{
    let XYZ = "1"
}
struct WebAPI {
    static let BaseUrl: String =  "http://boutinvm.eastus.cloudapp.azure.com/Distribute.svc/"
    static let LoginUrl: String = "\(BaseUrl)\("Authenticate")"
    static let SingUpUrl: String = "\(BaseUrl)\("NewUser")"
    static let NewListing: String = "\(BaseUrl)\("NewListing")"
     static let UpdateProfile: String = "\(BaseUrl)\("UpdateProfile")"
    static let Search: String = "\(BaseUrl)\("SearchTransactions")"
    
}

