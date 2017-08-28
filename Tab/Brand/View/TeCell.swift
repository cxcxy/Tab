//
//  T-Cell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
extension UILabel{
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        //        let statusLabelText:  = labelStr
        
        let size = CGSize.init(width: width, height: 900)
        
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
//            NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
//        let di = NSDictionary.init(object: <#T##Any#>, forKey: <#T##NSCopying#>)
        let strSize = labelStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        
        return strSize.height
        
    }
    func setLineHeightAndLineBreak(_ lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if let t = self.text {
            let attrString = NSMutableAttributedString(string: t)
            attrString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attrString.length))
            attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            self.attributedText = attrString
            
        }
    }
    func getSizeWithLabel(_ text: String, font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGFloat {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: (text.characters.count )))
        let stringSize = text.boundingRect(with: CGSize(width: CGFloat(width), height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle], context: nil).size
        return ceil(stringSize.height)
    }
    
    
    func ga_heightForComment( width: CGFloat, lineHegiht:CGFloat? = nil) -> CGFloat {
        
        var dic:[String:Any] = [NSFontAttributeName: self.font]
        
        if let l = lineHegiht {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = l
            paragraphStyle.lineBreakMode = .byCharWrapping
            
            dic[NSParagraphStyleAttributeName] = paragraphStyle
            dic[NSKernAttributeName] = l
            
        }
        
        
        
        let rect = NSString(string: self.text ?? "").boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: dic , context: nil)
        
        return ceil(rect.height)
    }
    
}
// 计算文字高度或者宽度与weight参数无关
extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, lineHegiht:CGFloat? = nil) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        var dic:[String:Any] = [NSFontAttributeName: font]

        
        if let l = lineHegiht {
        
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = l
            paragraphStyle.lineBreakMode = .byCharWrapping
 
            dic[NSParagraphStyleAttributeName] = paragraphStyle
            dic[NSKernAttributeName] = 1.5
            
        }
            
    
        
    
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: dic , context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
extension Array where Element == CGFloat {

    mutating func red(_ h:CGFloat)  {
        var hAll:CGFloat = 0.0
//        for item in self {
//            hAll += item
//        }
        hAll += ((self.last ?? 0.0) + 20)
        hAll += h
        self.append(hAll)
    }

}

class TeCell: UITableViewCell {
    
    var dataStoryArr : [StoryModel]? {
    
        didSet{
            configUI() 
        }
    
    }
    
    
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UIView!
    var pointArr : [CGFloat] = []
    
    var hArr : [CGFloat] = []
    var marginBottom : CGFloat = 10
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        
        
    }
    
    func configUI()  {
        guard let arr = dataStoryArr else {
            return
        }

        for view in self.textView.subviews {
            view.removeFromSuperview()
        }
        pointArr = []
        hArr     = []
        for item in arr.enumerated() {
            switch item.element.contentType {
            case 1:
                let h = item.element.content.ga_heightForComment(fontSize: 17, width: MGScreenWidth - 30)
                pointArr.red(h)
                hArr.append(h)
                self.setLabel(item.offset,str: item.element.content)
            case 2:
                
                let  itemHeight = WOWArrayAddStr.get_img_sizeNew(str: item.element.content, width: MGScreenWidth - 30, defaule_size: .OneToOne)
                pointArr.red(itemHeight)
                hArr.append(itemHeight)
                self.setImg(item.offset,str: item.element.content)
            default: break
                
            }
        }

        self.heightConstraint.constant = pointArr.last ?? 0.0

    }
    func setLabel(_ index:Int,str:String){
        var f = CGRect()
            f.x = 15
            f.w = MGScreenWidth - 30
            f.h = hArr[index]
        if index == 0 {

            f.y = 0

        }else{
            
            f.y = pointArr[index - 1]

        }
        
        let lb = UILabel()
        lb.frame = f
        lb.text = str
        lb.numberOfLines = 0
        lb.backgroundColor = UIColor.gray
        self.textView.addSubview(lb)
    }
    func setImg(_ index:Int,str:String){
        var f = CGRect()
        f.x = 15
        f.w = MGScreenWidth - 30
        f.h = hArr[index]
        if index == 0 {
            
            f.y = 0
            
        }else{
            
            f.y = pointArr[index - 1]
            
        }
        
        let lb = UIImageView()
        lb.frame = f
        
        lb.kf.setImage(with: URL.init(string: str)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        self.textView.addSubview(lb)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
