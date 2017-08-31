//
//  BrandGoodsCVCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/23.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BrandGoodsCVCell: UICollectionViewCell {

    @IBOutlet weak var imgGood: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var imgCountries: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var originalpriceLabel: UILabel!
    
    @IBOutlet weak var lbLabel: UILabel!// 冬日促销标签
    @IBOutlet weak var lbDiscount: UILabel!// 折扣标签
    @IBOutlet weak var lbNew: UILabel!// 新品标签
    
    @IBOutlet weak var lbRightLine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
