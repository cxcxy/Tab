//
//  Text_View_Cell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class Text_View_Cell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    var arr:[String] = [] {
        didSet{
            self.configContainerView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configContainerView()  {
        for items in arr {
            
        }
    }
    func newLabel()  {
        
    }
    func newImg() {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
