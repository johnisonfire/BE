//
//  AddBookViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
class customecell : UICollectionViewCell
{
    
    @IBOutlet weak var customimage: UIImageView!
}
class AddBookViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

//    "UserId" : 1,
//
//    "Name" : "Gears of Development2",
//
//    "ISBN" : "3254862897YU2",
//
//    "Image" : "An image goes here2",
//
//    "Author" : "Marcus Python2",
//
//    "Publisher" : "GenVieve",
//
//    "Edition" : "Second",
//
//    "ListPrice" : 75,
//
//    "Negotiable" : 1,
//
//    "Description" : "A newER development in programming.",
//
//    "Condition" : "new"
    let msgServerError = NSLocalizedString("Server_Error", comment: "Identifies server error")
     @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var txtAuther: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet var txtPublisher: UITextField!
    @IBOutlet var Edition: UITextField!
    @IBOutlet var txtNegotiable: UITextField!
    @IBOutlet weak var collectionSelectImage: UICollectionView!
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var txtCondition: UITextField!
    var imagearry : [AnyObject] = []
      var arrPhotos = [String]()
  //  var arrPhotos = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
     //   (self.tabBarController! as? tabViewController)?.configertabbar(Title: "Add Book", type: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.collectionSelectImage.reloadData()
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagearry.isEmpty
        {
            return 1
        }
        return imagearry.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customecell", for: indexPath) as! customecell
        if !imagearry.isEmpty
        {
            if  indexPath.row <= self.imagearry.count - 1
            {
                let image =  self.imagearry[indexPath.row]
                cell.customimage.image = (image as! UIImage)
            }else
            {
                cell.customimage.image = UIImage.init(named: "add.png")
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.height,height:collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !imagearry.isEmpty
        {
            if  indexPath.row <= self.imagearry.count - 2
            {
                let vc = BSImagePickerViewController()
                vc.maxNumberOfSelections = 1
                bs_presentImagePickerController(vc, animated: true,
                                                select: { (asset: PHAsset) -> Void in
                }, deselect: { (asset: PHAsset) -> Void in
                    //print("Deselected: \(asset)")
                }, cancel: { (assets: [PHAsset]) -> Void in
                    // print("Cancel: \(assets)")
                }, finish: { (assets: [PHAsset]) -> Void in
                    for asssets in assets
                    {
                        self.imagearry[indexPath.row] = self.getAssetThumbnail(asset: asssets)
                    }
                }, completion: { collectionView.reloadData()})
            }
            else
            {
                let vc = BSImagePickerViewController()
                vc.maxNumberOfSelections = 10
                bs_presentImagePickerController(vc, animated: true,
                                                select: { (asset: PHAsset) -> Void in
                }, deselect: { (asset: PHAsset) -> Void in
                    //print("Deselected: \(asset)")
                }, cancel: { (assets: [PHAsset]) -> Void in
                    // print("Cancel: \(assets)")
                }, finish: { (assets: [PHAsset]) -> Void in
                    for asssets in assets
                    {
                        self.imagearry.append(self.getAssetThumbnail(asset: asssets))
                    }
                }, completion: { collectionView.reloadData()})
                
            }
        }else
        {
            let vc = BSImagePickerViewController()
            vc.maxNumberOfSelections = 10
            bs_presentImagePickerController(vc, animated: true,
                                            select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
                //print("Deselected: \(asset)")
            }, cancel: { (assets: [PHAsset]) -> Void in
                // print("Cancel: \(assets)")
            }, finish: { (assets: [PHAsset]) -> Void in
                for asssets in assets
                {
                    self.imagearry.append(self.getAssetThumbnail(asset: asssets))
                }
            }, completion: { collectionView.reloadData()})
        }
    }
    
    @IBAction func btnPost(_ sender: Any) {
       var strGallaryImages = ""
        if imagearry.count > 0{
            for i in 0...self.imagearry.count - 1 {
                let Gimage  = (self.imagearry[i] as! UIImage)
                let imageData = UIImagePNGRepresentation(Gimage)!
                let dataStr = imageData.base64EncodedString(options: .endLineWithLineFeed) as String
                arrPhotos.append(dataStr)
            }
            //strGallaryImages = self.arrPhotos.componentsJoined(by: ",")
            
            print(arrPhotos)
        }else
        {
            strGallaryImages = ""
        }
        if txt_title.text == ""
        {
          Toast.makeText("Enter Title").show()
            return
        }else if txtPublisher.text == ""
        {
            Toast.makeText("Enter Publisher").show()
            return
        }
        else if txtAuther.text == ""
        {
            Toast.makeText("Enter Auther").show()
            return
        }
        else if txtPrice.text == ""
        {
            Toast.makeText("Enter Price").show()
            return
        }
        else if txtNegotiable.text == ""
        {
            Toast.makeText("Enter Negotiable").show()
            return
        }
        else if Edition.text == ""
        {
            Toast.makeText("Enter Edition").show()
            return
        }
        else if txtNegotiable.text == ""
        {
            Toast.makeText("Enter Negotiable").show()
            return
        }
        else if txtCondition.text == ""
        {
            Toast.makeText("Enter Condition").show()
            return
        }else
        {
        AddbookApi(Image: strGallaryImages)
        }
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        var retimage = UIImage()
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: nil, resultHandler: {(result, info)->Void in
            retimage = result!
        })
        return retimage
    }
    func AddbookApi(Image:String) {
        ActivityView.showActivityIndicator()
        let defaults = UserDefaults.standard
        
  
        let type = defaults.value(forKey: "loginType") as! String
        var userrid = ""
        if type == "login"
        {
            let userid = defaults.value(forKey: "UserDeail") as! String
            userrid = userid
        }else
        {
            let userid = defaults.value(forKey: "UserDeail") as! [NSString:Any]
            userrid = (userid["Data"] as! [NSString : Any])["UserId"] as! String
        }
        print(userrid)
        
        let dict = ["UserId" : userrid,
                   "Name" : txt_title.text!,
            
            "ISBN" : txtISBN.text!,
            
            "Images" : arrPhotos,
            
            "Author" : txtAuther.text!,
            
            "Publisher" : txtPublisher.text!,
            
            "Edition" : Edition.text!,
            
            "ListPrice" : txtPrice.text!,
            
            "Negotiable" : txtNegotiable.text!,
            
            "Description" : txtDescription.text!,
            
            "Condition" : txtCondition.text!
            ] as [String : Any]
        
        UserLoginService().Addbook(data: dict)
        { (response, error) -> () in
            ActivityView.hideActivityIndicator()
            if let err = error {
                Toast.makeText(err.localizedDescription).show()
            }else{
                if let responseObject = (self.convertToDictionary(text: (response as? String)!))! as? [String : Any]
                    
                {
                 self.imagearry = []
                    self.collectionSelectImage.reloadData()
                    self.txtISBN.text = ""
            
                    
                    self.txtAuther.text = ""
                    
                    self.txtPublisher.text = ""
                    
                    self.Edition.text! = ""
                    
                    self.txtPrice.text = ""
                    
                    self.txtNegotiable.text = ""
                    
                  self.txtDescription.text = ""
                    
                self.txtCondition.text = ""
                    let alertController = UIAlertController(title: "Book Uploaded", message: "Book uploaded sucessfully", preferredStyle: UIAlertControllerStyle.alert) //Replace
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        (result : UIAlertAction) -> Void in
                        print("OK")}
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }else
                {
                    let alertController = UIAlertController(title: "Book Upload Fail", message: "Book uploaded sucessfully", preferredStyle: UIAlertControllerStyle.alert) //Replace
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        (result : UIAlertAction) -> Void in
                        print("OK")}
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
