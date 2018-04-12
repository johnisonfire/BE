//
//  ListCollectionViewCell.swift
//  BookExchange
//
//  Created by PamSquade on 31/03/18.
//  Copyright © 2018 Christopher John Ison. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellPrice: UILabel!
    @IBOutlet weak var cellAuther: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
