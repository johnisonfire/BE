//
//  ProfileViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      //  (self.tabBarController! as? tabViewController)?.configertabbar(Title: "Profile", type: 2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logout(_ sender: Any) {
        
        guard let button = sender as? UIView else {
            return
        }
        let alertController = UIAlertController.init(title: "", message: "Logout Confirmation", preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionNo = UIAlertAction.init(title: "NO".localized, style: UIAlertActionStyle.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let actionYes = UIAlertAction.init(title: "YES".localized, style: UIAlertActionStyle.default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            let appdelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.setLoginStatus(LoggedInStatus.LoggedOut)
            let userStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let homeViewController = userStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            appdelegate.setRootViewController(homeViewController)
        }
        alertController.addAction(actionNo);
        alertController.addAction(actionYes);
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = button
            presenter.sourceRect = button.bounds
        }
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
    }
}
