//
//  AddBookViewController.swift
//  BookExchange
//
//  Created by PamSquade on 28/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit
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
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
     //   (self.tabBarController! as? tabViewController)?.configertabbar(Title: "Add Book", type: 1)
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
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.height-5,height:collectionView.frame.size.height-5)
    }
    @IBAction func btnPost(_ sender: Any) {
    }
}
