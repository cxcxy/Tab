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
