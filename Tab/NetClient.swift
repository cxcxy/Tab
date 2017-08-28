//
//  NetClient.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/17.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

struct NetClient {
    static let host = "http://api.dagoogle.cn"
    
    static let SUCCESSCODE    = 200
    
    static let RESULT_CODE    = "status"
    static let RESULT_MEG     = "error"
    static let RESULT_DATA    = "data"
    
//    static func send<R:Request>(_ r:R) -> Observable<[String:Any]> {
//        return Observable<[String:Any]>.create({ (observer) -> Disposable in
//            WOWNetManager.sharedManager.requestWithTarget(, successClosure: { (<#AnyObject#>, <#String?#>) in
//                
//            }, failClosure: { () in
//                
//            })
//            return Disposables.create {
//            }
//        })
//    }
}
