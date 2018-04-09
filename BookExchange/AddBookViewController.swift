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
class imagecell : UICollectionViewCell
{
    @IBOutlet weak var imagee: UIImageView!
}
class AddBookViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var txtAuther: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var collectionSelectImage: UICollectionView!
    
    var imagearry : [AnyObject] = []
    var arrPhotos = NSMutableArray()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Imagecell", for: indexPath) as! imagecell
        if !imagearry.isEmpty
        {
            if  indexPath.row <= self.imagearry.count - 1
            {
                let image =  self.imagearry[indexPath.row]
                cell.imagee.image = (image as! UIImage)
            }else
            {
                cell.imagee.image = UIImage.init(named: "add.png")
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
        if imagearry.count > 0{
            for i in 0...self.imagearry.count - 1 {
                
                let Gimage  = (self.imagearry[i] as! UIImage)
                //Compress Image
                //                let newsize = CGSize(width:100.0, height:100.0)
                //                UIGraphicsBeginImageContext(newsize)
                //                Gimage.draw(in: CGRect(x:0, y:0, width: 100.0,height:100.0))
                //                let GNewImage = UIGraphicsGetImageFromCurrentImageContext()!
                //                UIGraphicsEndImageContext()
                let imageData = UIImagePNGRepresentation(Gimage)!
                let dataStr = imageData.base64EncodedString(options: .endLineWithLineFeed) as String
                arrPhotos.add(dataStr)
                print(dataStr)
            }
            let strGallaryImages = self.arrPhotos.componentsJoined(by: ",")
            print(strGallaryImages)
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
   
}
