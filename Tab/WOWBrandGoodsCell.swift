//
//  WOWBrandGoodsCell.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/23.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
protocol SVColorCellDelegate:class{
    
    func updataTableViewCellHight(hight: CGFloat)
    
}
class WOWBrandGoodsCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPathNow:NSIndexPath!
     weak var delegate : SVColorCellDelegate?
    
     var dataArr = Variable<[String]>([])
    
     let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib.nibName(String(describing: BrandGoodsCVCell.self)), forCellWithReuseIdentifier: "BrandGoodsCVCell")

        
        dataArr.asObservable().subscribe(onNext: { [weak self](arr) in
            guard let strongSelf = self else{
                return
            }
            let c = arr.count.getParityCellNumber()
            strongSelf.heightConstraint.constant = (CGFloat(c) * 186.h) + (CGFloat(c - 1) * 20.h)
        }).addDisposableTo(disposeBag)
        

        
        
        dataArr.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "BrandGoodsCVCell", cellType: BrandGoodsCVCell.self)){ [weak self](row,elememt,cell) in
            
            
//            self?.updateCollectionViewHight(hight: (self?.collectionView.collectionViewLayout.collectionViewContentSize.height)!)
            
        }.addDisposableTo(disposeBag)
        
        
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
    }
    func updateCollectionViewHight(hight :CGFloat)  {
        
        self.heightConstraint.constant = hight
        self.delegate?.updataTableViewCellHight(hight: hight)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}


extension WOWBrandGoodsCell:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.w,height: 186.h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.h
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.w
    }
}
