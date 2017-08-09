//
//  BrandHostCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/3.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BrandHostCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
//        tableView.rowHeight            = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight   = 60
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
