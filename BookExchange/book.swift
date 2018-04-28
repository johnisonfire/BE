//
//  UserIntrest.swift
//  FlipNpik
//
//  Created by IBL Infotech on 5/18/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//
import UIKit
import Foundation
import ObjectMapper

class book: NSObject, Mappable {
    var author : String?
    var condition : AnyObject?
    var descriptionField : String?
    var edition : AnyObject?
    var iSBN : String?
    var images : AnyObject?
    var listPrice : Int?
    var name : String?
    var negotiable : Int?
    var publisher : String?
    var userId : Int?
    

    required init?(map: Map){}
   
    
    func mapping(map: Map)
    {
        author <- map["Author"]
        condition <- map["Condition"]
        descriptionField <- map["Description"]
        edition <- map["Edition"]
        iSBN <- map["ISBN"]
        images <- map["Images"]
        listPrice <- map["ListPrice"]
        name <- map["Name"]
        negotiable <- map["Negotiable"]
        publisher <- map["Publisher"]
        userId <- map["UserId"]
        
    }
}

