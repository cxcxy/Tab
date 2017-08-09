//
//  BrandRightView.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/3.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BrandRightView: UIView {
    
    @IBOutlet weak var view: UIView!
//    let lbTitle = UILabel()
    
    @IBOutlet weak var lb: UILabel!
    var title : String = "" {
        didSet  {
            lb.text = title
        }
    }
    func setup() {
        _ = Bundle.main.loadNibNamed("BrandRightView", owner: self, options: nil)?.last
        
        self.addSubview(self.view)
        self.view.frame = self.bounds
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

}
