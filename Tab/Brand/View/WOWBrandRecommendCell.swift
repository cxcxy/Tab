//
//  WOWBrandRecommendCell.swift
//  GIf
//
//  Created by 陈旭 on 2017/8/2.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
public extension UINib{
    
    class func nibName(_ name:String) ->UINib{
        return UINib(nibName: name, bundle: Bundle.main)
    }
}
public let MGScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let MGScreenHeight:CGFloat = UIScreen.main.bounds.size.height

protocol BrandDelegate:class {
    func reloadData()
}
struct StoryModel {
//    var id : Int?
    var contentType : Int
    var content : String
    
}
class WOWBrandRecommendCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var lbTitle: UILabel!
    
    var dataStoryArr:[StoryModel] = [StoryModel.init(contentType: 1, content: "https://img.wowdsgn.com/page/banners/1a18d4d1-f599-4d00-8d2d-c7c0e33b6d72_2dimension_1248x828.jpg"),
                                StoryModel.init(contentType: 1, content: "还有什么能够盛开"),
                                StoryModel.init(contentType: 1, content: "你知道我一直很乖")]
    
    
    weak var delegate : BrandDelegate?
    
    
    var dataArr = Variable<[String]>([])
    
    @IBOutlet weak var hightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cvBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var hightLbConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

        
        collectionView.register(UINib.nibName(String(describing: lb_Cell.self)), forCellWithReuseIdentifier: "lb_Cell")
        collectionView.register(UINib.nibName(String(describing: img_Cell.self)), forCellWithReuseIdentifier: "img_Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
        let layout                            = UICollectionViewFlowLayout()
        layout.scrollDirection                = .vertical

        
        layout.estimatedItemSize = CGSize.init(width: MGScreenWidth, height: 100)
        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize

//        
        layout.sectionInset                   = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.minimumInteritemSpacing        = 5
        
        layout.minimumLineSpacing             = 5
        collectionView.backgroundColor = UIColor.red
        collectionView.collectionViewLayout               = layout
        collectionView.reloadData()

     
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension WOWBrandRecommendCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let m = dataStoryArr[indexPath.row]
        if m.contentType == 1 {
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: lb_Cell.self), for: indexPath) as! lb_Cell
            
            cell.lbTitle.text = m.content
            return cell
        }else {
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: img_Cell.self), for: indexPath) as! img_Cell
            
            
            return cell
        }
 
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: MGScreenWidth - 50,height: 127)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
}
