//
//  WOWTwoDesLbCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/24.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class WOWTwoDesLbCell: UITableViewCell {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    let view_o = Des_lb_View.loadFromNib()
    let view_t = Des_lb_View.loadFromNib()
    
    let item_frame = CGRect.init(x: 0, y: 0, w: (MGScreenWidth - 1)/2, h: 160)
    
    override func awakeFromNib() {
        super.awakeFromNib()

        view_o.frame = item_frame
        view_t.frame = item_frame
        viewOne.addSubview(view_o)
        viewTwo.addSubview(view_t)
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension UIView: NibLoadable {
}
protocol NibLoadable {
    
}
extension NibLoadable where Self: UIView {
    
    static func loadFromNib() -> Self{
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}
