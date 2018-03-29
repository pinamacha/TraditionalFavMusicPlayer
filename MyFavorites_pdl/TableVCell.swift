//
//  TableVCell.swift
//  MyFavorites_pdl
//
//  Created by Ravi Pinamacha on 7/7/17.
//  Copyright © 2017 Ravi Pinamacha. All rights reserved.
//

import UIKit

class TableVCell: UITableViewCell {

    @IBOutlet weak var songNumber: UILabel!
    @IBOutlet weak var songTitleTelugu: UILabel!
    @IBOutlet weak var songTitleEnglish: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
