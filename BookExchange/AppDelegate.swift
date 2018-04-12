//
//  AppDelegate.swift
//  BookExchange
//
//  Created by Christopher John Ison on 3/24/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let merchantStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Override point for customization after application launch.
        switch getLoginStatus() {
        case .UserLoggedIn :
            let homeViewController = merchantStoryboard.instantiateViewController(withIdentifier: "tabViewController")
            self.setRootViewController(homeViewController)
        case .LoggedOut:
           
            let loginViewController = merchantStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.setRootViewController(loginViewController)
    }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Changing RootViewController of Application Window
    func setRootViewController(_ rootViewController: UIViewController) ->Void{
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    func setLoginStatus(_ status:LoggedInStatus) ->Void{
        let defaults = UserDefaults.standard
        defaults.setValue(status.rawValue, forKey: "LoginStatus")
        defaults.synchronize()
    }
    func getLoginStatus() ->LoggedInStatus {
        let defaults = UserDefaults.standard
        if let returnValue: String = defaults.value(forKey: "LoginStatus") as? String{
            return LoggedInStatus(rawValue: returnValue)!
        }
        return .LoggedOut
    }

}

