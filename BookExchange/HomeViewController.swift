//
//  HomeViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let FilterDropDown = DropDown()
    let Filter : NSMutableArray = ["Title","ISBN","Author"]
    var selectedindex = 0
    let BOok : [book] = [book]()
    var previousText = ""
    var data = NSMutableArray()
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet weak var mcollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       mcollectionview.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
        self.txtSearch.addTarget(self, action: #selector(searchFieldChanged(sender:)), for: .editingChanged)
        
        self.txtSearch.layer.cornerRadius = 5.0
        
        self.txtSearch.layer.masksToBounds = true
        
        self.txtSearch.layer.borderColor = UIColor.lightGray.cgColor
        
        self.txtSearch.layer.borderWidth = 2.0
        
        self.txtSearch.setLeftPaddingPoints(8.0)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
      //  (self.tabBarController! as? tabViewController)?.configertabbar(Title: "Home", type: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.data.count <= 0 && collectionView.backgroundView == nil {
            let noItemLabel = UILabel() //no need to set frame.
            noItemLabel.textAlignment = .center
            noItemLabel.textColor = .lightGray
            noItemLabel.text = NSLocalizedString("No Book Found", comment: "No posts message")
            collectionView.backgroundView = noItemLabel
        }
        collectionView.backgroundView?.isHidden = self.data.count > 0
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        let data = self.data[indexPath.row] as! [String:Any]
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.cellAuther.text = data["Publisher"] as? String
        cell.cellPrice.text = "$\(data["ListPrice"]!)"
        if data["Images"] != nil
        {
            if let urlString = data["Images"] as? String ,
                let url = URL(string: urlString) {
                cell.cellImage.sd_setShowActivityIndicatorView(true)
                cell.cellImage.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
                cell.cellImage.sd_setImageWithPreviousCachedImage(with: url, placeholderImage: UIImage(named: "picture.png"), options:[.continueInBackground], progress: nil, completed: { (image, error, cachetype, url) in
                })
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width/2-8,height:254)
    }

    /*
    // MARK: - Navigation

     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var openDropDown: UIButton!
    @IBAction func openDropDown(_ sender: Any) {
        FilterDropDown.dismissMode = .onTap
        
        FilterDropDown.direction   = .any
        
        FilterDropDown.anchorView  = openDropDown
        
        FilterDropDown.bottomOffset = CGPoint(x: -50, y: openDropDown.bounds.height)
        
        FilterDropDown.dataSource = (Filter as? [String])!
        
        FilterDropDown.selectionAction = { (index, item) in
            
            self.selectedindex = index
            
        }
        
        FilterDropDown.show()
        

    }
    @objc func searchFieldChanged(sender: Any) {
        
        let textField = sender as! UITextField
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchAndReload(keyWord:)), object: previousText)
        
        let trimmedString = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedString != "" {
            
            self.perform(#selector(searchAndReload(keyWord:)), with: textField.text, afterDelay: 0.5)
            
        }else {
            
            print("field is blank")
            
        }
        
        previousText = textField.text!
        
    }
    
    @objc func searchAndReload(keyWord: String){
        
            ActivityView.showActivityIndicator()
        UserLoginService().Search(Key: Filter[selectedindex] as! String, Value:keyWord)
            { (response, error) -> () in
                ActivityView.hideActivityIndicator()
                if let err = error {
                    Toast.makeText(err.localizedDescription).show()
                }else{
                    let strdata = response as! NSString
                    let dataa = strdata.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: dataa!, options : .allowFragments) as? [[String:Any]]
                        {
                            self.data = NSMutableArray()
                            for data in jsonArray
                            {
                                self.data.add(data)
                            }
                            self.mcollectionview.reloadData()
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                    
                }
            }
        }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.leftView = paddingView
        
        self.leftViewMode = .always
        
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.rightView = paddingView
        
        self.rightViewMode = .always
        
    }
    
}
