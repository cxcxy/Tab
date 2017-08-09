//
//  Untils.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/31.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper
public struct Untils {
    
   static func JSONStringify(_ value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                //                DLog("error")
                
            }
        }
        return ""
        
    }
}



extension Observable {
    func toMapJson() -> Observable<[String: Any]> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard let code = dict["resCode"] as? String else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if code == "0" {
                print("网络请求成功")
            }
            guard let data = dict["data"] as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            return data
        }
    }

    
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {

        return self.toMapJson().map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error

            
//            guard let code = dict["resCode"] as? String else {
//                throw RxSwiftMoyaError.ParseJSONError
//            }
//            if code == "0" {
//                print("网络请求成功")
//            }
//            guard let data = dict["data"] as? [String: Any] else {
//                throw RxSwiftMoyaError.ParseJSONError
//            }
            
            
            return Mapper<T>().map(JSON: response)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }


extension String {
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
}


public enum Defaule_Size : Float{
    
    case ThreeToTwo = 0.67
    case ThreeToOne = 0.33
    case OneToOne   = 1
}
/**
 转换数组url
 - parameter array:     需要转化的数组
 
 - returns:
 */
struct WOWArrayAddStr {
    static func strAddJPG(array : [String]) -> Array<String>{
        var newArray = [String]()
        for a in 0..<array.count {
            var str = array[a]
            str = String(format: "%@?imageMogr2/format/jpg", str)
            newArray.append(str)
            
        }
        return newArray
    }
    // 后台返回的图片后面有图片size的参数 此方法拿到。直接返回算出的高度
    static func get_img_sizeNew(str:String,width:CGFloat,defaule_size:Defaule_Size) -> CGFloat {
        
        let array = str.components(separatedBy: "_2dimension_")
        
        var rate        = defaule_size.rawValue
        if array.count > 1 {
            let c = array[1].components(separatedBy: ".")
            if c.count >= 1 {
                let d = c[0].components(separatedBy: "x")
                if d.count > 1 {
                    
                    if let height = d[1].toFloat(),let width = d[0].toFloat() {
                        rate = height / width
                    }
                    
                }
            }
            
        }
        return round(CGFloat(rate) * width)
    }
    
    
    // 后台返回的图片后面有图片size的参数 此方法拿到。 默认 1比1
    static func get_img_size(str:String) -> Float {
        
        let array = str.components(separatedBy: "_2dimension_")
        var pointArr:[String] = ["100","100"]
        
        if array.count > 1 {
            
            pointArr = array[1].components(separatedBy: ".")[0].components(separatedBy: "x")
            
        }
        return pointArr[1].toFloat()! / pointArr[0].toFloat()!
    }
    // 后台返回的图片后面有图片size的参数 此方法拿到。 默认 三比二
    static func get_img_size_withThreeTwo(str:String) -> Float {
        
        let array = str.components(separatedBy: "_2dimension_")
        var pointArr:[String] = ["100","67"]
        
        if array.count > 1 {
            
            pointArr = array[1].components(separatedBy: ".")[0].components(separatedBy: "x")
            
        }
        return pointArr[1].toFloat()! / pointArr[0].toFloat()!
    }
    
    // 后台返回的图片后面有图片size的参数 此方法拿到。 默认 三比二
    static func get_imageAspect(str:String) -> Float {
        
        let array = str.components(separatedBy: "_2dimension_")
        var pointArr:[String]
        
        if array.count > 1 {
            
            pointArr = array[1].components(separatedBy: ".")[0].components(separatedBy: "x")
            return pointArr[0].toFloat()! / pointArr[1].toFloat()!
            
        }
        return 0
    }
    
}

