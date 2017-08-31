//
//  GroupModel.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/31.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxDataSources
import ObjectMapper


class WOWHotStyleModel: Mappable {
    var id                          :   Int?
    var columnId                    :   Int?
    var columnName                  :   String?
    var columnIcon                  :   String?
    var topicName                   :   String?
    var topicImg                    :   String?
    var topicMainTitle              :   String?
    var brandId                     :   Int?
    var designerId                  :   Int?
    var topicDesc                   :   String?
    var topicType                   :   Int?
    var favoriteQty                 :   Int?
    var readQty                     :   Int?
    var publishTime                 :   Int?
    var status                      :   Int?
    var deleted                     :   Bool?
    var favorite                    :   Bool?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                          <- map["id"]
        columnId                    <- map["columnId"]
        columnName                  <- map["columnName"]
        columnIcon                  <- map["columnIcon"]
        topicName                   <- map["topicName"]
        topicImg                    <- map["topicImg"]
        topicMainTitle              <- map["topicMainTitle"]
        brandId                     <- map["brandId"]
        designerId                  <- map["designerId"]
        topicDesc                   <- map["topicDesc"]
        topicType                   <- map["topicType"]
        favoriteQty                 <- map["favoriteQty"]
        readQty                     <- map["readQty"]
        publishTime                 <- map["publishTime"]
        status                      <- map["status"]
        deleted                     <- map["deleted"]
        favorite                    <- map["favorite"]
    }
    
}



class GroupModelData {
    static let shareInstance = GroupModelData()
    
    var page : Int = 1
    
    private init (){
    }
    func getGroupModelData( successAction: @escaping  (Observable<[RefundReason]>)  -> ())  {
        page += 1
        loadData(page) { (arr) in
            successAction(Observable.just(arr).observeOn(MainScheduler.instance).shareReplay(1))
        }

    }
    func loadData(_ currentPage: Int = 1 ,successAction: @escaping  ([RefundReason]) -> ())  {
        let url = URL.init(string: "http://10.0.60.121:8080/v2/product/recommend?")
        
        let params = [
            "currentPage": currentPage,
            "pageSize": 10,
            ]
        let parameters: Parameters = [
            "paramJson" : Untils.JSONStringify(params as AnyObject)
            
        ]
        Alamofire.request(url!, method: .get, parameters: parameters).responseJSON {response in
            
            if let data = response.data, let json = String(data: data, encoding: .utf8) {
                  print(json)
//                let info = Mapper<ReturnInfo>().map(JSONString: Untils.JSONStringify(response as AnyObject))
                    let info = Mapper<ReturnInfo>().map(JSONString:json)
                let bannerList = Mapper<RefundReason>().mapArray(JSONObject:(JSON(info?.data!)["productVoList"]).arrayObject)
//                let info = Mapper<ReturnInfo>().map(JSONString:json)
                
//                if let strongSelf = self {
//                    let arr = info?.data?.productVoList
                    if let arr = bannerList {
                        successAction(arr)
                    }
                
//                    strongSelf.dataArr.value.append(contentsOf: arr!)
//                    strongSelf.mj_footer.endRefreshing()
                    
//                }
                
            }
            
        }
    }

}

class ArticleModel:NSObject {
    static let shareInstance   = ArticleModel()
    
    fileprivate var loadData = PublishSubject<Int>()
    
    public var refresh:Variable<RefreshStatus> = Variable(.Unknown)
//    var coulumId : Int
//    
//    // 自定义构造函数,通知指定属性的值
//    init(id : Int) {
////        self.name = name
////        self.age = age
//        self.coulumId = id
//    }
    
    private override init() {
        super.init()
    }
    
    
    func getArticleListData(_ params:[String:AnyObject]) -> Observable<[WOWHotStyleModel]> {
        return Observable.create { observer -> Disposable in

            WOWNetManager.sharedManager.requestWithTarget(.api_userFeedBack(params : params), successClosure: {(result,code) in
                
                    let bannerList = Mapper<WOWHotStyleModel>().mapArray(JSONObject:JSON(result)["topics"].arrayObject)
                
                    if let bannerList = bannerList{
                           observer.onNext(bannerList)
                        if bannerList.count < 10 {// 如果拿到的数据，小于分页，则说明，无下一页
                            self.refresh.value = .NoMoreData
                            
                            
                        }else {
                            self.refresh.value = .PushSuccess
                        }

                    }
    
                
                
            }) { (errorMsg) in
                    observer.onError(NetError.CustomError(errorStr: errorMsg ?? "").handle())
            }
            return Disposables.create {
            }
            
        }
    }
    
}

public enum NetError:Swift.Error {
    case HTTPError(NSError)
    case CustomError(errorStr:String)
    case DataError
    
    
    func handle() -> NetError {

        switch self {
        case NetError.CustomError(let errorStr):
            
            print("===" + errorStr)
            
        default:
            break
        }

        return self
    }
}


public enum RefreshStatus: Int {
    case PushSuccess
    case PushFailure
    case PullSuccess
    case PullFailure
    case NoMoreData
    case Unknown
}






class test: Mappable {
    var productVoList       : [RefundReason]?
      var isOpne                  : Bool?  = false
   required init?(map: Map) {
        
    }
     func mapping(map: Map) {
        productVoList           <- map["productVoList"]
        
    }
}
class Tes: test {
    
}

class Res: Mappable {
    var title       :  String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        title           <- map["productTitle"]
        
    }
}


class RefundReason: Res  {
    var productImg       : String?

     override func mapping(map: Map) {
        super.mapping(map: map)
        productImg           <- map["productImg"]
    }
}


////MARK:前后端约定的返回数据结构
//class ReturnInfo: Mappable {
//    var data:test? //若返回无数据，returnObject字段也得带上,可为空值
//    var code: String?
//    var message: String?
//    required init?(map: Map) {
//    }
//    
//    func mapping(map: Map) {
//        data          <-    map["data"]
//        code          <-    map["resCode"]
//        message       <-    map["resMsg"]
//    }
//}


class GroupViewModel {

    func getGroups(params:[String:Any]) -> Observable<test> {
        return provider.request(.getGroupList(params: params)).mapJSON().mapObject(type: test.self)
//        return provider.request(.getGroupList(params: params)).mapJSON().mapArray(type: RefundReason.self)
//        return provider.request(.getGroupList(params: params)).mapJSON().mapObject(type: ReturnInfo.self)
    }
//    func getSectionsGroups(params:[String:Any]) -> Observable<SectionModel<String, test>> {
//        return Observable.create({ (observer) -> Disposable in
//            
//        })
    
        
//        return provider.request(.getGroupList(params: params)).mapJSON().mapObject(type: test.self)
        
        //        return provider.request(.getGroupList(params: params)).mapJSON().mapArray(type: RefundReason.self)
        //        return provider.request(.getGroupList(params: params)).mapJSON().mapObject(type: ReturnInfo.self)
    
}
struct Speaker {
    let name: String
    let twitterHandle: String
    var image: UIImage?
    
    init(name: String, twitterHandle: String) {
        self.name = name
        self.twitterHandle = twitterHandle
     
    }
}

struct SpeakerListViewModel {
    let data = Observable.of([
        Speaker(name: "Ben Sandofsky", twitterHandle: "@sandofsky"),
        Speaker(name: "Carla White", twitterHandle: "@carlawhite"),
        Speaker(name: "Jaimee Newberry", twitterHandle: "@jaimeejaimee"),
        Speaker(name: "Natasha Murashev", twitterHandle: "@natashatherobot"),
        Speaker(name: "Robi Ganguly", twitterHandle: "@rganguly"),
        Speaker(name: "Virginia Roberts",  twitterHandle: "@askvirginia"),
        Speaker(name: "Scott Gardner", twitterHandle: "@scotteg")
        ])
}
class WOWProductCommentModel: WOWBaseModel, Mappable{
    var nickName                : String?
    var avatar                  : String?
    var comments                : String?
    var commentImgs             : [String]?
    var specAttributes          : [String]?
    var isReplyed               : Bool?
    var employeeRealName        : String?
    var replyContent            : String?
    var publishTimeFormat       : String?
    var timeStamp               : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nickName            <- map["nickName"]
        avatar              <- map["avatar"]
        comments            <- map["comments"]
        commentImgs         <- map["commentImgs"]
        specAttributes      <- map["specAttributes"]
        isReplyed           <- map["isReplyed"]
        employeeRealName    <- map["employeeRealName"]
        replyContent        <- map["replyContent"]
        publishTimeFormat   <- map["publishTimeFormat"]
        timeStamp           <- map["timeStamp"]
    }
    
}
/*--------------*/
class WOWPrizesNameModel: WOWBaseModel,Mappable {
    
    var  prizeName : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        prizeName                          <- map["prizeName"]

    }

}
class WOWCertificationsModel: WOWBaseModel,Mappable {
    
    var  certImageUrl : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        certImageUrl                          <- map["certImageUrl"]
        
    }
    
}
class WOWSizeImagesModel: WOWBaseModel,Mappable {
    
    var  title      : String?
    var  imageUrl   : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title                               <- map["title"]
        imageUrl                            <- map["imageUrl"]
    }
    
}

class WOWIntroductionsModel: WOWBaseModel,Mappable {
    
    var  content        : String?
    var  type           : Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        content                                 <- map["content"]
        type                                    <- map["type"]
    }
    
}
class WOWNewProductInfoModel: WOWBaseModel,Mappable{
    
    var prizes                              : [WOWPrizesNameModel]?
    var certifications                      : [WOWCertificationsModel]?
    var sizeImages                          : [WOWSizeImagesModel]?
    var introductions                       : [WOWIntroductionsModel]?

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        prizes                          <- map["prizes"]
        certifications                  <- map["certifications"]
        sizeImages                      <- map["sizeImages"]
        introductions                   <- map["introductions"]
 
    }
}

/*--------------*/
class WOWProductModel: NSObject,Mappable{
    
    
    var productId             : Int?
    var primaryImgs           : Array<String>?
    var productName           : String?
    var productTitle          : String?
    var sellPrice             : Double?
    var originalprice         : Double?
    var sellingPoint          : String?
    var brandCname            : String?
    var brandId               : Int?
    var brandLogoImg          : String?
    var designerId            : Int?
    var designerName          : String?
    var designerPhoto         : String?
    var detailDescription     : String?
    var productParameter      : [WOWParameter]?
    var productImg            : String?
    var secondaryImgs         : [WOWProductPicTextModel]?
    
    var productStatus         : Int?
    var sings                 : [WOWProductSings]?
    dynamic var timeoutSeconds : Int = 0
    var favorite              : Bool?
    var discount              : String?
    var productStock          : Int?
    //商品限购信息
    
    var limitTag                    : String?
    
    //商品详情中用到
    var length                      : NSNumber?
    var width                       : NSNumber?
    var height                      : NSNumber?
    var netWeight                   : NSNumber?
    var attributes                  : [WOWSerialAttributeModel]?
    var availableStock              : Int?
    var hasStock                    : Bool?
    var productQty                  : Int?
    var isOversea                   : Bool? //是否海购,是-true,否-false
    var logisticsMode               : Int?  //1-海外直邮，2-保税区直邮
    var originCountry               : String?   //国家名字
    var originCountryId             : Int?      //国家id
    /******************新版商品详情***********************/
    var productImgs                 : [WOWProductSkuModel]?     //可滑动sku图片列表
    var designerInfo                : WOWDesignerInfoModel?
    var brandInfo                   : WOWBrandInfoModel?
    var mainlyForBrand              : Bool?
    
    override init() {
        super.init()
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        
        /*************************新版Map***********************/
        productId               <- map["productId"]
        productName             <- map["productTitle"]
        productTitle            <- map["productTitle"]
        
        sellPrice               <- map["sellPrice"]
        originalprice           <- map["originalPrice"]
        sellingPoint            <- map["sellingPoint"]
        brandCname              <- map["brandCname"]
        brandId                 <- map["brandId"]
        brandLogoImg            <- map["brandLogoImg"]
        designerName            <- map["designerName"]
        designerId              <- map["designerId"]
        designerPhoto           <- map["designerPhoto"]
        detailDescription       <- map["detailDescription"]
        productParameter        <- map["parameters"]
        productImg              <- map["productImg"]
                secondaryImgs           <- map["secondaryImgs"]
        
        productStatus           <- map["productStatus"]
        sings                   <- map["signs"]
        timeoutSeconds          <- map["timeoutSeconds"]
        
        productStock            <- map["productStock"]
        
        favorite                <- map["favorite"]
        
        length                      <- map["length"]
        width                       <- map["width"]
        height                      <- map["height"]
        netWeight                   <- map["netWeight"]
        attributes                  <- map["attributes"]
        availableStock              <- map["availableStock"]
        hasStock                    <- map["hasStock"]
        
        isOversea                   <- map["isOversea"]
        logisticsMode               <- map["logisticsMode"]
        originCountry               <- map["originCountry"]
        originCountryId             <- map["originCountryId"]
        productImgs                 <- map["productImgs"]
        designerInfo                <- map["designerInfo"]
        brandInfo                   <- map["brandInfo"]
        mainlyForBrand              <- map["mainlyForBrand"]
    }
    
    /// 商品列表瀑布流需要用的高度
    var cellHeight:CGFloat = 0
    func calCellHeight(){
        //        let s = self.productShortDes ?? ""
        //        var height = s.heightWithConstrainedWidth((MGScreenWidth - CGFloat(3)) / CGFloat(2) - 30, font: UIFont.systemScaleFontSize(13))
        //        height = height > 18 ? 30 : 18
        //        self.cellHeight = 20 + 5 + 14 + height + 6 + WOWGoodsSmallCell.itemWidth
    }
    
}
class WOWDesignerInfoModel: WOWBaseModel,Mappable{
    var designerId                 : Int?
    var designerName               : String?
    var designerLogoImg            : String?
    var designerDesc               : String?
    var country                 : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        designerId                 <- map["id"]
        designerName               <- map["designerName"]
        designerLogoImg            <- map["designerLogoImg"]
        designerDesc               <- map["designerDesc"]
        country                 <- map["country"]
    }
}





class WOWBrandInfoModel: WOWBaseModel,Mappable{
    var brandId                 : Int?
    var brandName               : String?
    var brandLogoImg            : String?
    var brandDesc               : String?
    var country                 : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        brandId                 <- map["id"]
        brandName               <- map["brandName"]
        brandLogoImg            <- map["brandLogoImg"]
        brandDesc               <- map["brandDesc"]
        country                 <- map["country"]
    }
}
class WOWProductSings: WOWBaseModel,Mappable {
    
    var id                  : Int?
    var desc                : String?
    var extra               : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id              <- map["id"]
        desc            <- map["desc"]
        extra           <- map["extra"]
        
    }
    
}
class WOWProductPicTextModel:WOWBaseModel,Mappable {
    var image  :String?
    var text    :String?
    var imageAspect:CGFloat = 0
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["url"]
        text  <- map["desc"]
        if imageAspect == 0 {
            imageAspect = CGFloat(WOWArrayAddStr.get_imageAspect(str: image ?? ""))// 拿到图片的宽高比,
            if imageAspect == 0 {
                calImageHeight()
            }
        }
    }
    
    func calImageHeight(){
        //定义NSURL对象
        
        let url = URL(string: image ?? "")
        
        if let url = url {
            
            DispatchQueue.global(qos: .background).async {
                do{
                    
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data ) {
                        //计算原始图片的宽高比
                        
                        self.imageAspect = image.size.width / image.size.height
                        //            //设置imageView宽高比约束
                        //            //加载图片
                        //
                    }
                }catch let e {
//                    DLog(e)
                }
                
            }
            
        }
    }
}


class WOWProductSkuModel: WOWBaseModel,Mappable {
    var productImg      : String?
    var specDesc        : String?
    
    required init?( map: Map) {
        
    }
    
    func mapping(map: Map) {
        productImg      <- map["productImg"]
        specDesc        <- map["specDesc"]
    }
}

class WOWAttributeModel: WOWBaseModel,Mappable{
    
    var code        :String?
    var title       :String?
    var value       :String?
    var attriImage  :String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code        <- map["key"]
        value       <- map["value"]
        title       <- map["label"]
        attriImage  <- map["pic_app"]
    }
}

class WOWParameter: WOWBaseModel,Mappable{
    
    var parameterShowName        :String?
    var parameterValue           :String?
    
    required init?(map: Map) {
        
    }
    
    init(parameterShowName: String, parameterValue: String) {
        self.parameterShowName = parameterShowName
        self.parameterValue = parameterValue
    }
    
    func mapping(map: Map) {
        parameterShowName            <- map["parameterShowName"]
        parameterValue               <- map["parameterValue"]
    }
}

class WOWProductSpecModel: WOWBaseModel,Mappable {
    var products                     : [WOWProductModel]?
    var serialAttribute             : [WOWSerialAttributeModel]?
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        products                         <- map["products"]
        serialAttribute             <- map["attributes"]
    }
}



class WOWSerialAttributeModel: WOWBaseModel, Mappable {
    var attributeId                 : Int?
    var attributeName               : String?
    var attributeShowName           : String?
    var attributeValues             : Array<String>?
    var attributeValue              : String?
    var specName                    = [WOWSpecNameModel]()
    
    required init?(map: Map) {
        
        
    }
    
    func mapping(map: Map) {
        attributeId                   <- map["attributeId"]
        attributeName                 <- map["attributeName"]
        attributeShowName             <- map["attributeShowName"]
        attributeValues               <- map["attributeValues"]
        attributeValue                <- map["attributeValue"]
        if let attri = attributeValues{
            for a in attri {
                let model = WOWSpecNameModel(specName: a, isSelect: false, isCanSelect: true)
                specName.append(model)
            }
            
        }
    }
    
}




class WOWSpecNameModel: WOWBaseModel {
    var specName                           : String
    var isSelect                           : Bool
    var isCanSelect                        : Bool
    init(specName: String, isSelect: Bool, isCanSelect: Bool) {
        self.specName = specName
        self.isSelect = isSelect
        self.isCanSelect = isCanSelect
    }
    
}

class WOWBaseModel:NSObject {
    
}
