//
//  WOWDesignerCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/23.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class WOWDesignerCell: UITableViewCell {

    @IBOutlet weak var lbCountries: UILabel!
    @IBOutlet weak var imgDesiginer: UIImageView!
    @IBOutlet weak var imgBrand: UIImageView!
    
    @IBOutlet weak var lbTitieName: UILabel!
    
    @IBOutlet weak var lbDes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
