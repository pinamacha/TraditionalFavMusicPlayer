//
//  CollectionViewCell.swift
//  MyFavorites_pdl
//
//  Created by Ravi Pinamacha on 7/7/17.
//  Copyright © 2017 Ravi Pinamacha. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumBg: UIImageView!
 
    @IBOutlet weak var albumNameTelugu: UILabel!
    
    @IBOutlet weak var albumNameEnglish: UILabel!
    override func draw(_ rect: CGRect) {
        super.draw(rect)


        albumBg.layer.cornerRadius = albumBg.frame.height/2
        albumBg.clipsToBounds = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
