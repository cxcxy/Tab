//
//  WOWSelectUserCommentsCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/23.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class WOWSelectUserCommentsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
// MARK: - Font : 13 , textColor = 65686C
class lb_Des_Style: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.font = UIFont.systemFont(ofSize: 13)
        self.textColor = UIColor.init(hexString: "65686C")
    }

}
