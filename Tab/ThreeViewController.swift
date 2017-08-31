//
//  ThreeViewController.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/31.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit


enum ProductElement :String{
    case Header             = "header"              // 顶部header
    case Oversea            = "oversea"             // 是否有海购
    case Prizes             = "prizes"              // 是否有获奖信息
    case DesignerInfo       = "designerInfo"        // 是否有 设计师信息
    case BrandInfo          = "brandInfo"           // 是否有 品牌信息
    case Introductions      = "introductions"       // 是否有图文详情
    case SelectComment      = "selectComment"       // 是否有精选评论
    case SizeImages         = "sizeImages"          // 是否有规格信息
    case Parameter          = "parameter"           // 是否 有参数
    case Tips               = "tips"                // 是否 有温馨提示
    case Certifications     = "certifications"      // 是否有 相关证书信息
    case Comment            = "comment"             // 是否有评论 晒图
    case AboutProductArr    = "aboutProductArr"     // 是否有相关商品
}


class ThreeViewController: UIViewController {

    var isOne : Bool = true
    var isTwo : Bool = false
    var isThree : Bool = true
    var isFour : Bool = true
    
    
    var productId                       : Int   = 2339                //产品id
    
    var productSpecModel                : WOWProductSpecModel?  //产品规格model
    
    
    var aboutProductArray               = [WOWProductModel]()   //相关商品数组
    
    
    
    var commentList = [WOWProductCommentModel]() //评论列表
    
    let disposeBag = DisposeBag()
    
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,Any>>()
    
    var dataArr  = Variable<[SectionModel<String,Any>]>([])
    
    
    let viewModel  = GroupViewModel()
    var pageIndex = 1
    var isOpen : Bool = false
    

    

    
    var productModel                    : WOWProductModel! //产品model
    var productNewInfoModel                    : WOWNewProductInfoModel! //产品model
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle            = .none
        self.tableView.rowHeight            = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight   = 60
        
        
        tableView.register(UINib.init(nibName: "WOWApplyAfterCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWApplyAfterCell")
        tableView.register(UINib.init(nibName: "WOWSelectUserCommentsCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWSelectUserCommentsCell")
        tableView.register(UINib.init(nibName: "WOWBrandRecommendCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWBrandRecommendCell")
        tableView.register(UINib.init(nibName: "BrandStoryCell", bundle: Bundle.main), forCellReuseIdentifier: "BrandStoryCell")
        tableView.register(UINib.init(nibName: "Text_View_Cell", bundle: Bundle.main), forCellReuseIdentifier: "Text_View_Cell")
        tableView.register(UINib.init(nibName: "WOWTwoDesLbCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWTwoDesLbCell")
        tableView.register(UINib.init(nibName: "WOWBrandGoodsCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWBrandGoodsCell")
        
        tableView.register(UINib.init(nibName: "WOWTwoGoodsImgCell", bundle: Bundle.main), forCellReuseIdentifier: "WOWTwoGoodsImgCell")

        
        
//        let hg = Observable.from(request(),viewDidLoad())
        
    
        
        if isOne {
            
            self.dataArr.value.append(SectionModel.init(model: "isOne",
                                                    items: [Module.init(des: "1111111222222啊六点开始给发货速度发啊叫啊叫短款礼服哈只能下次 v 看啊就打开了飞机啊哭了低中年级考虑爱噢点击分卡家；啦都来自农村吗菂哦书法家了；阿道夫快乐；啊激动哭了哭宗角禄康 v 家拉开的烦恼看了考场女看男自噢家adorn阿奎罗放假啊可怜的飞机离开了看着你下次哦 v 啊就哦 if你你啊发髻；埃及看哪都开了房间",
                                                                                    img: "https://img.wowdsgn.com/page/banners/2c7589b3-7ffb-41b7-8df2-a5a2551dc143_2dimension_1248x624.jpg",
                                                                                    img1: "https://img.wowdsgn.com/page/banners/2c7589b3-7ffb-41b7-8df2-a5a2551dc143_2dimension_1248x624.jpg")]))
        }
        
        if isTwo {
            
            let s = Section_Module.init(sectionTitle: "哈哈哈")
            let m = Module.init(des: "2222222", img: "https://img.wowdsgn.com/page/banners/73a2b371-5888-4906-a990-25e47f708cab_2dimension_904x603.jpg", img1: nil)
            self.dataArr.value.append(SectionModel.init(model: "isTwo",
                                                    items: [s,m])
            )
            
        }
        
        
   

        dataArr.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
                
        
        dataSource.configureCell = { [unowned self](data_source , tableView , indexPath , element) in
            
            
            let s =     data_source.sectionModels[indexPath.section]
            print(s.model)
    
            switch s.model {
            case ProductElement.Header.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WOWBrandGoodsCell") as! WOWBrandGoodsCell
                
                
                cell.dataArr.value =  ["1",
                                       "2",
                                       "3",
                                       "1",
                                       "2",
                                       "3"]
                return cell
            case "isTwo":
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WOWBrandGoodsCell") as! WOWBrandGoodsCell
                    
                    
                    cell.dataArr.value =  ["1"
                                           
                                            ]
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WOWBrandGoodsCell") as! WOWBrandGoodsCell
                    
                    
                    cell.dataArr.value =  ["1",
                                           "2","3","4"
                        ]
                    return cell
                default:
                    return UITableViewCell()
                }

            default:
                return UITableViewCell()
            }
            
            
            
            
            
        }
        
        
        
        // 点击事件
        tableView.rx
            .itemSelected
            .map { [unowned self] (indexPath) in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                print("Tapped `\(model)` @ \(indexPath)")
            })
            .addDisposableTo( disposeBag)
        
        
        
        
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        request()

      
    }
    
    func Append_DataArr(_ setctionStr:ProductElement,sectionItems:[Any]) {

        self.dataArr.value.append(SectionModel.init(model: setctionStr.rawValue,
                                                    items: sectionItems))
        
    }
    func configData()  {
        
        
        for singModel in productModel.sings ?? []{
            switch singModel.id ?? 0{

            case 5: //是否有限购
                    print("")
            case 6: //是否有促销

                    print("")
            default: break
                
            }
        }
//        if let productImgs = productModel.productImgs { // 是否有多于的 SKU 图片
            self.Append_DataArr(.Header, sectionItems: [productModel])
//        }
        
        if let isOversea = productModel.isOversea { // 是否海购
            self.Append_DataArr(.Oversea, sectionItems: [productModel])
        }
        
        if "prizes" == "" { // 是否有获奖信息
            self.Append_DataArr(.Prizes, sectionItems: [productModel])
        }
        if let designerInfo = productModel.designerInfo { // 是否有 设计师信息
            self.Append_DataArr(.DesignerInfo, sectionItems: [productModel])
        }
        if let brandInfo = productModel.brandInfo {// 是否有 品牌信息
            self.Append_DataArr(.BrandInfo, sectionItems: [productModel])
        }
        if "introductions" == "" { // 是否有图文详情
            self.Append_DataArr(.Introductions, sectionItems: [productModel])
        }
        
        if  commentList.count > 0 { // 是否有精选评论
            self.Append_DataArr(.SelectComment, sectionItems: [productModel])
        }
        
        if "sizeImages" == "" { // 是否有规格信息
            self.Append_DataArr(.SizeImages, sectionItems: [productModel])
        }
        if let parameter = productModel.productParameter {// 是否 有参数
        self.Append_DataArr(.Parameter, sectionItems: [productModel])
        }
        if "Tips"  == "" { // 是否 有温馨提示
            self.Append_DataArr(.Tips, sectionItems: [productModel])
        }
        
        if "certifications" == "" { // 是否有 相关证书信息
            self.Append_DataArr(.Certifications, sectionItems: [productModel])
        }
        if  commentList.count > 0 { // 是否有评论 晒图
            self.Append_DataArr(.Comment, sectionItems: [productModel])
        }


        if aboutProductArray.count > 0 {// 是否有相关商品
            self.Append_DataArr(.AboutProductArr, sectionItems: [productModel])
        }
        
    }
    func request()  {
        
        WOWNetManager.sharedManager.requestWithTarget(.api_ProductDetail(productId: productId), successClosure: {[weak self] (result, code) in
            if let strongSelf = self{
                //商品过期
                if code == RequestCode.ProductExpired.rawValue {
                    
//                    strongSelf.productExpired()
                    return
                }
//                strongSelf.productEffectView.isHidden = true
                strongSelf.productModel = Mapper<WOWProductModel>().map(JSONObject:result)
                strongSelf.configData()
                
                //产品参数里面要拼接上尺寸重量
//                strongSelf.configParameter()
//                strongSelf.requestCommentList()
//                strongSelf.buyCarCount()
                

            }
        }) {[weak self](errorMsg) in
            if let strongSelf = self{

            }
        }

    }
    //商品评论
    func requestCommentList() {
        ///获取评论列表
        WOWNetManager.sharedManager.requestWithTarget(.api_ProductCommentList(pageSize: 6, currentPage: 1, productId: productId), successClosure: {[weak self] (result, code) in
            if let strongSelf = self{
                let r = JSON(result)
                let arr = Mapper<WOWProductCommentModel>().mapArray(JSONObject:r["productCommentList"].arrayObject)
                if let array = arr{
                    strongSelf.commentList = array
                }

            }
            
            
        }){[weak self] (errorMsg) in
            if let strongSelf = self{

                strongSelf.requestAboutProduct()

            }
            
        }
        
    }
    // 相关商品信息
    func requestAboutProduct()  {
        let params = ["productId": productId, "currentPage": 1,"pageSize":6] as [String : Any]
        WOWNetManager.sharedManager.requestWithTarget(RequestApi.api_ProductAbout(params: params as [String : AnyObject]), successClosure: {[weak self] (result, code) in
            
            if let strongSelf = self {
                let arr = Mapper<WOWProductModel>().mapArray(JSONObject:JSON(result)["productVoList"].arrayObject)
                
                if let array = arr{
                    strongSelf.aboutProductArray = array
                    
                }
                //初始化详情页数据
                strongSelf.configData()

            }
            
            
        }) {[weak self] (errorMsg) in
            
            if let strongSelf = self{
                //初始化详情页数据
                strongSelf.configData()

            }
        }
    }
    
    // 相关商品信息
    func requestNewProduct()  {
  
        WOWNetManager.sharedManager.requestWithTarget(RequestApi.api_ProductInformations(groupId: productId), successClosure: {[weak self] (result, code) in
            
            if let strongSelf = self {

                let model = Mapper<WOWNewProductInfoModel>().map(JSONObject:result)
                if let m = model{
                    
                    strongSelf.productNewInfoModel = m
                    
                }
                //初始化详情页数据
                strongSelf.configData()
       
            }
            
            
        }) {[weak self] (errorMsg) in
            
            if let strongSelf = self{
                //初始化详情页数据
                strongSelf.configData()

            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    


}

extension ThreeViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}


//{
//    currentPage = 1;
//    pageSize = 6;
//    productVoList =     (
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1502450892000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 199;
//            oversea = 0;
//            productId = 12369;
//            productImg = "https://img.wowdsgn.com/product/images/35aa74b9-e9e2-4189-9af4-70187e4748ba.png";
//            productStatus = 1;
//            productTitle = "\U82b1\U56ed\U6f2b\U6b65-\U9999\U85b0\U7cbe\U6cb9\U6563\U9999\U5668 TABAC PATCHOULI";
//            sellPrice = 199;
//    },
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1502342762000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 6;
//            oversea = 0;
//            productId = 11961;
//            productImg = "https://img.wowdsgn.com/product/images/0479d6e2-7e1d-4308-b49e-e89392bdd505.jpg";
//            productStatus = 1;
//            productTitle = "WOWDSGN \U4e03\U5915\U8d3a\U5361";
//            sellPrice = 6;
//    },
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1500875863000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 520;
//            oversea = 0;
//            productId = 11125;
//            productImg = "https://img.wowdsgn.com/product/images/a45f61d4-806d-425f-9750-a4f111855eba.jpg";
//            productStatus = 1;
//            productTitle = "\U4e18\U6bd4\U7279\U7684\U73ab\U7470";
//            sellPrice = 520;
//    },
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1503298858000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 499;
//            oversea = 0;
//            productId = 10955;
//            productImg = "https://img.wowdsgn.com/product/images/fc6aeaec-96bb-4cba-af79-5851736a9964.jpg";
//            productStatus = 1;
//            productTitle = "\U5730\U4e2d\U6d77\U4e4b\U5fc3 \U7231\U795e\U676f \U91d1\U676f";
//            sellPrice = 499;
//    },
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1503298253000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 499;
//            oversea = 0;
//            productId = 10953;
//            productImg = "https://img.wowdsgn.com/product/images/03e8607b-ee85-45be-ac8e-6905b2879b52.jpg";
//            productStatus = 1;
//            productTitle = "Flora\U7cfb\U5217 \U7231\U4e3d\U4e1d\U9e22\U5c3e\U7231\U795e\U676f \U91d1\U676f";
//            sellPrice = 499;
//    },
//        {
//            isOversea = 0;
//            logisticsMode = 0;
//            onShelfTime = 1503297668000;
//            originCountry = "\U4e2d\U56fd";
//            originCountryId = 107;
//            originalPrice = 499;
//            oversea = 0;
//            productId = 10951;
//            productImg = "https://img.wowdsgn.com/product/images/6e6b2ce3-9f46-468a-abaa-f2716f56f9ff.jpg";
//            productStatus = 1;
//            productTitle = "Flora\U7cfb\U5217 \U5965\U65af\U6c40\U73ab\U7470\U7231\U795e\U676f \U91d1\U676f";
//            sellPrice = 499;
//    }
//    );
//    totalPage = 11;
//    totalResult = 65;
//})
