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
class GroupModelData {
    static let shareInstance = GroupModelData()
    
    var page : Int = 1
    
    private init (){}
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
                let info = Mapper<ReturnInfo>().map(JSONString:json)
                
//                if let strongSelf = self {
                    let arr = info?.data?.productVoList
                    if let arr = arr {
                        successAction(arr)
                    }
                
//                    strongSelf.dataArr.value.append(contentsOf: arr!)
//                    strongSelf.mj_footer.endRefreshing()
                    
//                }
                
            }
            
        }
    }

}
//class ContainerViewModel {
//    var models: Driver<[RefundReason]>
//    
//    init(withSearchText searchText: Observable<String>, service: GroupModelData) {
//        models = searchText
//            .debug()
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .flatMap { text in
//                return service.getGroupModelData()
//            }.asDriver(onErrorJustReturn: [])
//    }
//}
//

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


//MARK:前后端约定的返回数据结构
class ReturnInfo: Mappable {
    var data:test? //若返回无数据，returnObject字段也得带上,可为空值
    var code: String?
    var message: String?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        data          <-    map["data"]
        code          <-    map["resCode"]
        message       <-    map["resMsg"]
    }
}


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
