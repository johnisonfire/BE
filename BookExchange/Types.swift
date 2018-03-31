//
//  Types.swift
//  chirag
//
//  Created by Chirag Patel on 11/03/16.
//  Copyright © 2016 iOS Developer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias Coordinate = (lattitude: String, longitude: String)

//
//enum LikeStatus: Int {
//    case like = 1
//    case superLike
//    case love
//}
//
//class Address: NSObject {
//    var area: String?
//    var city: String?
//    var state: String?
//    var postalCode: String?
//    var location: Coordinate?
//}

enum LoggedInStatus: String{
    case UserLoggedIn
    case LoggedOut
}

extension UIViewController {
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    @objc func navigateBack() ->Void {
       _ = self.navigationController?.popViewController(animated: true)
    }
    func configureFor() ->Void{
        self.title = ""
        self.navigationItem.hidesBackButton = true
        let image = UIImage(named: "backarrow")
        let leftButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(UIViewController.navigateBack))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
    
    func configureBaseNavigationBar(_ title: String) ->Void{
        self.title = title
        self.navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(named: "backarrow"), style: .plain, target: self, action: #selector(UIViewController.navigateBack))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
}



