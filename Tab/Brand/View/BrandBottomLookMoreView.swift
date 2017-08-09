//
//  BrandBottomLookMoreView.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/4.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
typealias WOWActionClosure         = () -> ()

class BrandBottomLookMoreView: UIView {

    @IBOutlet weak var view: UIView!
 
    @IBOutlet weak var img_mask: UIImageView!
    var block:WOWActionClosure?
    
    @IBAction func LookAction(_ sender: Any) {
        print("点击")
        if let block = block {
            block()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view.frame = self.bounds
        self.view.updateConstraints()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
    }
    func setup() {
//        let view = UINib.init
        let v = Bundle.main.loadNibNamed("BrandBottomLookMoreView", owner: self, options: nil)?.last as! UIView
          v.frame = self.bounds
        self.addSubview(v)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
//    required init?(coder aDecoder: NSCoder) {
//        
//    }

}
