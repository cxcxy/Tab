//
//  WOWBrandGoodsCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/23.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class WOWBrandGoodsCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
     var dataArr = Variable<[String]>([])
    
     let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib.nibName(String(describing: BrandGoodsCVCell.self)), forCellWithReuseIdentifier: "BrandGoodsCVCell")
//         collectionView.collectionViewLayout = self.layout
        dataArr.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "BrandGoodsCVCell", cellType: BrandGoodsCVCell.self)){ [weak self](row,elememt,cell) in
            
            
            
            
        }.addDisposableTo(disposeBag)
        
        
        
        
//        collectionView.rx.modelSelected(WOWHotStyleModel.self).subscribe(onNext: {[weak self](model) in
//            guard let s = self else {
//                return
//            }
//            
//            
//        }).addDisposableTo(disposeBag)
        
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)

        
    }
    /// lazy
//    lazy var layout:CollectionViewWaterfallLayout = {
//        let l = CollectionViewWaterfallLayout()
//        l.columnCount               = 2
//        l.minimumColumnSpacing      = 15
//        l.minimumInteritemSpacing   = 25
//        l.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        return l
//    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//extension WOWBrandGoodsCell:CollectionViewWaterfallLayoutDelegate{
//    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150.w,height: 180.h)
//    }
//}

extension WOWBrandGoodsCell:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.w,height: 180.h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 25
    }
}
