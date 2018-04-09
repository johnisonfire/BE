//
//  SignUpViewController.swift
//  BookExchange
//
//  Created by PamSquade on 27/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
let msgServerError = NSLocalizedString("Server_Error", comment: "Identifies server error")
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSignup(_ sender: Any) {
        if self.txtUsername.text == ""
        {
          Toast.makeText("Enter UserName").show()
        }else if self.txtEmail.text == ""
        {
            Toast.makeText("Enter Email address").show()
        }else if !isValidEmail(testStr: self.txtEmail.text!)
        {
           Toast.makeText("Enter Valid Email address").show()
        }
        else if self.txtPhone.text == ""
        {
            Toast.makeText("Enter Phone Number").show()
        }else if !validate(value: self.txtPhone.text!)
        {
            Toast.makeText("Enter valid Phone Number").show()
        }else if self.password.text == ""
        {
          Toast.makeText("Enter password").show()
        }
        else if self.confirmPassword.text == ""
        {
          Toast.makeText("Enter confirm Password").show()
        }
        else if self.confirmPassword.text != self.password.text
        {
           Toast.makeText("Enter confirm Password and password not match.").show()
        }else{
          callregisterApi()
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func validate(value: String) -> Bool {
        if value.characters.count >= 10
        {
            return true
        }
        return false
    }
    func callregisterApi()
    {
        ActivityView.showActivityIndicator()
        UserLoginService().Register(userName: txtUsername.text!, password: password.text!, PhoneNumber: txtPhone.text!, EmailAddress: txtEmail.text!) { (response, error) -> () in
            ActivityView.hideActivityIndicator()
            if let err = error {
                Toast.makeText(err.localizedDescription).show()
            }else{
                //print(response)
                
                if let responseObject = (convertToDictionary(text: (response as? String)!))! as? [String : AnyObject] {
                        Toast.makeText(responseObject["Error"]! as! String).show()
                }else if let responseObject = response as? String
                {
                    let appdelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.setLoginStatus(LoggedInStatus.UserLoggedIn)
                    let defaults = UserDefaults.standard
                    defaults.set(responseObject, forKey: "UserDeail")
                    let userStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let homeViewController = userStoryboard.instantiateViewController(withIdentifier: "LoginTabbar")
                    appdelegate.setRootViewController(homeViewController)
                }else{
                    Toast.makeText(self.msgServerError).show()
                }
            }
        }
    }
}
