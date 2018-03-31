//
//  ViewController.swift
//  BookExchange
//
//  Created by Christopher John Ison on 3/24/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let msgServerError = NSLocalizedString("Server_Error", comment: "Identifies server error")
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin(_ sender: Any) {
        if txtUserName.text == ""
        {
          Toast.makeText("UserName Input").show()
        }else if txtPassword.text == ""
        {
          Toast.makeText("Password Input").show()
        }else
        {
        self.viewLogin()
        }
    }
    @IBAction func btnCreateNewAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUpVC", sender: self)
    }
    func viewLogin() {
        ActivityView.showActivityIndicator()
        UserLoginService().login(email: txtUserName.text!, password: txtPassword.text!) { (response, error) -> () in
            ActivityView.hideActivityIndicator()
            if let err = error {
                Toast.makeText(err.localizedDescription).show()
            }else{
               
                if (response as? String) != nil
                {
                    let appdelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.setLoginStatus(LoggedInStatus.UserLoggedIn)
                    let userStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let homeViewController = userStoryboard.instantiateViewController(withIdentifier: "LoginTabbar")
                    appdelegate.setRootViewController(homeViewController)
                }
                else{
                    Toast.makeText(self.msgServerError).show()
                }
                
            }
        }
    }
}

