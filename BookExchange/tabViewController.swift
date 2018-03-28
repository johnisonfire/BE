//
//  tabViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class tabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.tabBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isHidden = false
        
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configertabbar(Title:String,type:Int) {
      self.title = Title
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
