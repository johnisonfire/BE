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
        (self.tabBarController! as? tabViewController)?.configertabbar(Title: "Profile", type: 2)
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
        self.navigationController?.popToRootViewController(animated: true)
    }
}
