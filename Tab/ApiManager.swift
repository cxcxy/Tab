//
//  ApiManager.swift
//  Tab
//
//  Created by 陈旭 on 2017/8/1.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import Moya

enum ApiManager {
    case getGroupList(params: [String: Any])
    case getLaunchImg
    case getNewsList
    case getMoreNews(String)
    case getThemeList
    case getThemeDesc(Int)
    case getNewsDesc(Int)
}
let provider = RxMoyaProvider<ApiManager>()
extension ApiManager: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://10.0.60.121:8080/")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getLaunchImg:
            return "7/prefetch-launch-images/750*1142"
        case .getNewsList:
            return "4/news/latest"
        case .getMoreNews(let date):
            return "4/news/before/" + date
        case .getThemeList:
            return "4/themes"
        case .getThemeDesc(let id):
            return "4/theme/\(id)"
        case .getNewsDesc(let id):
            return "4/news/\(id)"
        case .getGroupList:
            return "v2/product/recommend"
        }
       
        
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        var params = [String: Any]()
        
        switch self{
        case let .getGroupList(param):
            params = param
        default:
            break

        }
        params =   ["paramJson":Untils.JSONStringify(params as AnyObject)]
        return params
    }
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
