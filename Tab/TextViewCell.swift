//
//  TextViewCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/4.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit




protocol T_TextDelegate:class {
    
    func heightAllChange()
    
}
class TextViewCell: UITableViewCell {

    @IBOutlet weak var htightViewConstraint: NSLayoutConstraint!
    
    var data : Module! {
        didSet{
            self.configLabel(data: data)
        }
    }
    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var label_TY: TYAttributedLabel!
    @IBOutlet weak var tv_view: UIView!
    @IBOutlet weak var bottomView: BrandBottomLookMoreView!
    @IBOutlet weak var bottom_mask: UIImageView!
    weak var delegate :T_TextDelegate?
    var heightAll :CGFloat = 0.0 {
        didSet {
            self.heightConstraint.constant = heightAll
        }
    }
    var isOpen : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        
        bottomView.addTapGesture {[unowned self] (sender) in

            if self.isOpen {
                
                self.bottomView.img_mask.isHidden = false
                self.isOpen = !self.isOpen
                self.htightViewConstraint.constant = 200
                
            }else {
                
                self.bottomView.img_mask.isHidden = true
                self.isOpen = !self.isOpen
                
                self.htightViewConstraint.constant = self.heightAll + 52
                
            }

            self.layoutIfNeeded()
            if let del = self.delegate {
                del.heightAllChange()
            }
            

        }
    }
    @IBAction func clickAction(_ sender: Any) {
        
    }
    func configLabel(data:Module){

        label_TY.text = ""
        
        if let img = data.img {
            
            self.appendImg(imgUrl: img)
            
        }
        
        if let des = data.des {
            label_TY.appendText(des)
        }
        if let img1 = data.img1 {
            self.appendImg(imgUrl: img1)
        }
        label_TY.paragraphSpacing = 50
        label_TY.sizeToFit()
      
        self.heightAll = label_TY.bounds.size.height

    }
    func appendImg(imgUrl:String)  {
        let  itemHeight = WOWArrayAddStr.get_img_sizeNew(str: imgUrl, width: MGScreenWidth, defaule_size: .OneToOne)
        let imageUr = TYImageStorage()
        imageUr.imageURL = URL.init(string: imgUrl)
        imageUr.imageAlignment  = TYImageAlignmentCenter
        imageUr.size = CGSize.init(width: MGScreenWidth, height: itemHeight + 20)
        label_TY.appendTextStorage(imageUr)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
