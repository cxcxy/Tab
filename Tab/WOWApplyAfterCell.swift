//
//  WOWApplyAfterCell.swift
//  wowdsgn
//
//  Created by 陈旭 on 2017/5/3.
//  Copyright © 2017年 g. All rights reserved.
//

import UIKit
extension WOWApplyAfterCell:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        CGRect bounds = textView.bounds;
//        
//        // 计算 text view 的高度
//        CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//        CGSize newSize = [textView sizeThatFits:maxSize];
//        bounds.size = newSize;
//        
//        textView.bounds = bounds;
//        
//        // 让 table view 重新计算高度
//        UITableView *tableView = [self tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
        var bounds = textView.bounds
        let maxSize = CGSize.init(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let newSize = textView.sizeThatFits(maxSize)
        bounds.size = newSize
        textView.bounds = bounds
//        if let del = delegate  {
//            del.heightChange()
//        }
    }
}
protocol TVDelegate:class {
    
    func heightChange()

}
class WOWApplyAfterCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var rightView: BrandRightView!
    @IBOutlet weak var imgAicon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    let textViewFont = UIFont.systemFont(ofSize: 12)
    @IBOutlet weak var lbDescribe: UILabel!
     var all_heigth  : CGFloat = 0.0
    weak var delegate : TVDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.red
        textView.isEditable = false


    }

    override func prepareForReuse() {

    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
