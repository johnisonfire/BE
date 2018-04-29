//
//  ProfileViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
 let msgServerError = NSLocalizedString("Server_Error", comment: "Identifies server error")
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
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
        if txtFirstName.text == ""
        {
        Toast.makeText("Enter First Name").show()
         return
        }else if txtLastName.text == ""
        {
            Toast.makeText("Enter Last Name").show()
         return
        }else if txtEmail.text == ""
        {
            Toast.makeText("Enter Email Name").show()
          return
        }
        else if !isValidEmail(testStr: txtEmail.text!)
        {
            Toast.makeText("Enter Valid Email").show()
          return
        }
        else if txtPhoneNumber.text == ""
        {
           Toast.makeText("Enter Phone Number").show()
         return
        }
        else if txtPassword.text == ""
        {
            Toast.makeText("Enter Password").show()
            return
        }else
        {
          self.profileupdateApi()
        }
        
       
    }
     @IBAction func Save(_ sender: Any) {
        guard let button = sender as? UIView else {
            return
        }
        let alertController = UIAlertController.init(title: "", message: "Logout Confirmation", preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionNo = UIAlertAction.init(title: "NO".localized, style: UIAlertActionStyle.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let actionYes = UIAlertAction.init(title: "YES".localized, style: UIAlertActionStyle.default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "UserDeail")
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
    func profileupdateApi() {
        ActivityView.showActivityIndicator()
        let defaults = UserDefaults.standard
        let userid = defaults.value(forKey: "UserDeail") as! [NSString:Any]
        
        UserLoginService().ProfileEdit(userName: (userid["Data"] as! [NSString : Any])["UserId"] as! String, FirstName: txtFirstName.text!, LastName: txtLastName.text!, password: txtPassword.text!, PhoneNumber: txtPhoneNumber.text!, EmailAddress: txtEmail.text!) { (response, error) -> () in
            ActivityView.hideActivityIndicator()
            if let err = error {
                Toast.makeText(err.localizedDescription).show()
            }else{
                //print(response)
                if let responseObject = (self.convertToDictionary(text: (response as? String)!))! as? [String : Any]
                {
                    if Int(responseObject["Status"]! as! String) == 1
                    {
                     self.txtFirstName.text = ""
                        self.txtLastName.text = ""
                        self.txtPhoneNumber.text = ""
                        self.txtEmail.text = ""
                        let alertController = UIAlertController(title: "Alert", message: "Profile Update Sucessfully!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                        {
                            (result : UIAlertAction) -> Void in
                         
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else{
                        Toast.makeText(self.msgServerError).show()
                    }
                }
                
            }
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
