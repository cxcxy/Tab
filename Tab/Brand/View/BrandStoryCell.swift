//
//  BrandStoryCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/3.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
protocol BrandStoryDelegate:class {
    
    func updateHeightCell()
    
}
class BrandStoryCell: UITableViewCell{

    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
     @IBOutlet weak var lbModuleName: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    
    @IBOutlet weak var htightViewConstraint: NSLayoutConstraint! // bottomView height layout
    
//    var data : Brand_Story_Model! {
//        didSet{
//            self.configUI()
//        }
//    }

    @IBOutlet weak var heightTVConstraint: NSLayoutConstraint! // textView height Layout
    
    @IBOutlet weak var label_TY: UIView! // textView

    
    @IBOutlet weak var bottomView: UIView! //底部查看更多 view
    

    @IBOutlet weak var lookMoreView: UIView!
    
    @IBOutlet weak var img_expand: UIImageView!
    @IBOutlet weak var img_mask: UIImageView!
    
    @IBOutlet weak var btnType: UIButton!
    
    var dataStoryArr : [StoryModel]? {
        
        didSet{
            configNewUI()
        }
        
    }
    
    var pointArr : [CGFloat] = []
    
    var hArr : [CGFloat] = []

    
    
    var max_Height:CGFloat = 507 - 130  // 最大高度， 是textView 图文混编的最大高度，  则 减去  顶部 标题的高度 130
    
    weak var delegate :BrandStoryDelegate?
    
    var isOpen :Bool = false
    
    var heightAll :CGFloat = 0.0 {  // 遍历完数据， 最终的 textView 高度
        didSet {
            self.updateTextViewHeightLayout(heightAll)
        }
    }
    func configUI(){
        
//        self.lbTitle.text = data.title ?? ""
//        self.lbSubtitle.text = data.subTitle ?? " "
//        if let country_flag  = data.country {
//            if country_flag == "" {
//                self.imgCountry.isHidden = true
//            }else {
//                
//                self.imgCountry.isHidden = false
//                let ImgStr = "countryflags_" + country_flag
//                self.imgCountry.image = UIImage(named: ImgStr)
//                
//            }
//            
//
//        }else {
//              self.imgCountry.isHidden = true
//        }

        
//        if  data.isOpne == false {
//            self.btnType.setTitle("阅读全文", for: .normal)
//            self.img_expand.transform = CGAffineTransform.identity
//            self.img_mask.alpha  = 1.0
//        }

        
//        
//        self.configLabel(data: data)
        
    }
    // 更新textView高度
    func updateTextViewHeightLayout(_ h:CGFloat){
        
        self.heightTVConstraint.constant = h
        if h > max_Height {
//            if data.isOpne {
//                self.htightViewConstraint.constant = h + 52
//            }else{
                self.htightViewConstraint.constant = max_Height
//            }
            
            bottomView.isHidden  = false
        }else {
            bottomView.isHidden  = true
            self.htightViewConstraint.constant = h
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        lookMoreView.addTapGesture { [weak self](sender) in
            guard let strongSelf = self else {
                return
            }
            


            if strongSelf.isOpen {
                strongSelf.isOpen = !strongSelf.isOpen
                strongSelf.htightViewConstraint.constant = strongSelf.max_Height
                strongSelf.btnType.setTitle("阅读全文", for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    strongSelf.img_mask.alpha = 1.0
//                    strongSelf.img_expand.transform = CGAffineTransform.identity
                    strongSelf.layoutIfNeeded()
                })
                if let del = strongSelf.delegate {
                    del.updateHeightCell()
                }
                
                
            }else {
                strongSelf.isOpen = !strongSelf.isOpen
                strongSelf.htightViewConstraint.constant = strongSelf.heightAll + 52
                strongSelf.btnType.setTitle("收起", for: .normal)
                
                UIView.animate(withDuration: 0.3, animations: {
                    strongSelf.img_mask.alpha = 0.0
//                    strongSelf.img_expand.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                    if let del = strongSelf.delegate {
                        del.updateHeightCell()
                    }
                    
                }, completion: { (completion) in
                    strongSelf.layoutIfNeeded()
                    
                })
                
            }
            

        }
//


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func configLabel(data:Brand_Story_Model){ // 渲染UI
//        
//        label_TY.text = ""
//        
//        if let datails = data.details  {
//            
//            for item in datails {
//                switch item.contentType ?? 0 {
//                case 1:
//                    label_TY.appendText((item.content ?? "") + "\n")
//                case 2:
//                if let img = item.content {
//                    self.appendImg(imgUrl: img)
//                }
//                default: break
//                    
//                }
//            }
//            
//        }
//        
//        label_TY.paragraphSpacing = 20
//        label_TY.sizeToFit()
//        self.heightAll = label_TY.bounds.size.height
//        
//    }
//    func appendImg(imgUrl:String)  {
//        let  itemHeight = WOWArrayAddStr.get_img_sizeNew(str: imgUrl, width: MGScreenWidth, defaule_size: .OneToOne)
//        let imageUr = TYImageStorage()
//        imageUr.imageURL = URL.init(string: imgUrl)
//        imageUr.imageAlignment  = TYImageAlignmentCenter
//        imageUr.size = CGSize.init(width: MGScreenWidth, height: itemHeight + 20)
//        label_TY.appendTextStorage(imageUr)
//    }

}
extension BrandStoryCell {
    func configNewUI()  {
        guard let arr = dataStoryArr else {
            return
        }
        
        for view in self.label_TY.subviews {
            view.removeFromSuperview()
        }
        pointArr = []
        hArr     = []
        for item in arr.enumerated() {
            switch item.element.contentType {
            case 1:

                self.setLabel(item.offset,str: item.element.content)
            case 2:
                
                let  itemHeight = WOWArrayAddStr.get_img_sizeNew(str: item.element.content, width: MGScreenWidth - 30, defaule_size: .OneToOne)
                pointArr.red(itemHeight)
                hArr.append(itemHeight)
                self.setImg(item.offset,str: item.element.content)
            default: break
                
            }
        }
        self.heightAll = pointArr.last ?? 0.0

        
    }
    func setLabel(_ index:Int,str:String){
        
        
        let lb = UILabel()
       
        lb.text  = str
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.init(hexString: "F65686C")
//        lb.setLineHeightAndLineBreak(1.5) 
        
        
        let h = lb.ga_heightForComment(width: MGScreenWidth - 30,lineHegiht: 1.5)
        pointArr.red(h)
        hArr.append(h)
        
        var f = CGRect()
        f.x = 15
        f.w = MGScreenWidth - 30
        f.h = 100
        if index == 0 {
        
            f.y = 0
            
        }else{
//
            f.y = pointArr[index - 1]
//
        }
        
        lb.frame = f
        
        self.label_TY.addSubview(lb)
    }
    func setImg(_ index:Int,str:String){
        var f = CGRect()
        f.x = 15
        f.w = MGScreenWidth - 30
        f.h = 100
        if index == 0 {
//
            f.y = 0
            
        }else{
//
            f.y = pointArr[index - 1]
//
        }
        
        let lb = UIImageView()
        lb.frame = f
        
        lb.kf.setImage(with: URL.init(string: str)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        self.label_TY.addSubview(lb)
    }


}
