//
//  WOWRequestApi.swift
//  Wow
//
//  Created by 王云鹏 on 16/3/18.
//  Copyright © 2016年 wowdsgn. All rights reserved.
//

import Moya
import SwiftyJSON

public enum RequestApi{
    
    
    static var HostUrl:String! = BaseUrl
    
    case api_qiniu_token(qiniuKey: String, bucket: String)
    
    case api_AD
    case api_Sence
    case api_checkVersion(params: [String: AnyObject]?)
    
    case api_User
    //Tab 第一个栏 首页 该死的那3个url
    case api_Home_Banners
    case api_Home_Tabs
    // 首页Url
    case api_Home_List(params: [String: AnyObject]?)
    case api_floatWindow
    // 首页底部列表
    case api_Home_BottomList(params: [String: AnyObject]?)
    // 精选页底部列表
    case api_HotStyle_BottomList(params: [String: AnyObject]?)
    
    //筛选 页面
    case Api_Screen_Main
    case Api_Screen_Price(categoryId:Int)
    
    case api_AddressAdd(receiverName: String, provinceId: Int, cityId: Int, countyId: Int, addressDetail: String, receiverMobile: String, isDefault:Bool)
    
    case api_Addresslist
    
    case api_AddressDelete(id:Int)
    
    case api_AddressSetDefault(id:Int)
    
    case api_AddressDefault
    
    case api_AddressEdit(id: Int, receiverName: String, provinceId: Int, cityId: Int, countyId: Int, addressDetail: String, receiverMobile: String, isDefault:Bool)
    
    case api_SenceDetail(sceneid:String,uid:String)
    
    //搜索
    case api_SearchHot
    
    case api_SearchResult(params: [String: AnyObject])
    
    //品牌
    case api_BrandList
    
    case api_BrandDetail(brandId: Int)
    
    case api_ProductBrand(params: [String: AnyObject])
    //设计师
    case api_DesignerDetail(designerId: Int)
    
    case api_productDesigner(designerId: Int, pageSize: Int, currentPage: Int)
    
    case api_DesignerList //设计师列表
    
    
    case api_Category(categoryId:Int) //查看分类
    
    case api_Category_subCategory_with_image(categoryId:Int) //查看分类并且带上对应销量第一的商品的图片
    case api_Category_path_category(categoryId:Int) //查看分类 获得上级分类或者上上级分类的
    
    case api_Product_By_Category(params: [String: AnyObject])//查看分类下商品 asc 0 降序 当前页 showCount  sortBy 1 categoryId
    
    case api_Captcha(mobile:String) //绑定微信验证码
    
    case api_ProductGroupTop(groupId : Int)// 分组产品 上边的 图片接口
    
    case api_ProductGroupList(params: [String: AnyObject])// 分组产品 下面列表
    
    
    case api_userFeedBack(params: [String: AnyObject])
    
    case api_ProductInformations(groupId : Int)// 
    
    
    //购物车相关
    case api_CartModify(shoppingCartId:Int, productQty:Int)
    
    case api_CartRemove(shoppingCartId:[Int])
    
    case api_CartAdd(productId: Int, productQty: Int)
    
    case api_CartGet
    
    case api_CartSelect(shoppingCartIds: [Int])
    
    case api_CartUnSelect(shoppingCartIds: [Int])
    // 无购物车时。显示列表
    case api_CartBottomList(pageSize: Int, currentPage: Int)
    
    case api_TopicCommentList(pageSize: Int, currentPage: Int, topicId: Int, lastId: Int)
    //商品评价
    case api_ProductCommentList(pageSize: Int, currentPage: Int, productId: Int)
    
    case api_Change(param:[String:String])
    
    case api_ProductAbout(params: [String: AnyObject])
    //用户收藏相关
    case api_FavoriteProduct(productId: Int)
    
    case api_FavoriteBrand(brandId: Int)
    
    case api_FavoriteDesigner(designerId: Int)
    
    case api_IsFavoriteProduct(productId: Int)
    
    case api_FavoriteTopicComment(commentId: Int)
    
    case api_IsFavoriteBrand(brandId: Int)
    
    case api_IsFavoriteDesigner(designerId: Int)
    
    case api_LikeProduct
    
    case api_LikeBrand
    
    case api_LikeDesigner
    
    case api_LikeProject(topicId: Int)
    
    case api_Coupons(params: [String: AnyObject]? )  //用户优惠券列表
    
    case api_GetCoupon(redemptionCode: String)  //获取优惠券
    
    case api_ProductsOfCoupon(pageSize: Int, currentPage: Int, sortColumn: Int, sortType: Int, id: Int)
    
    case api_Invite //邀请好友
    
    case api_Login(String,String)
    
    case api_Logout
    
    case api_LoginCaptcha(mobile: String)
    
    case api_LoginByCaptcha(mobile: String, captcha:String)
    
    //订单相关
    
    case api_OrderList(params: [String: AnyObject]?)
    
    case api_OrderDetail(OrderCode:String)
    
    
    case api_OrderStatus(uid: String, order_id: String, status: String)
    
    case api_OrderSettle
    
    case api_OrderBuyNow(productId: Int, productQty: Int)
    
    case api_OrderCreate(params: [String: AnyObject])
    
    case api_OrderCharge(params: [String: AnyObject])
    
    case api_PayResult(orderCode: String)
    
    case api_OrderConfirm(orderCode: String)
    
    case api_OrderCancel(orderCode: String)
    
    case api_OrderComment(orderCode: String)// 订单商品评论列表
    
    case api_OederReminder(orderCode: String)
    
    case api_OrderPushComment(params: [String: AnyObject]?)// 提交评论内容
    
    case api_GetRefundMoney(saleOrderItemId: Int,isWholeRefund:Bool? )
    
    case api_CreatRefund(params: [String: AnyObject])
    
    case api_GetRefundDetail(refundId:Int)
    
    case api_GetRefundList(params: [String: AnyObject])
    
    case api_GetRefundLog(orderCode: String? , saleOrderItemRefundId: Int? )
    
    case api_GetRefundProcess(saleOrderItemRefundId:Int)
    
    case api_GetCancelRefund(saleOrderItemRefundId:Int)
    
    case api_EntryRefundInfo(params: [String: AnyObject])
    
    case api_ProductDetail(productId: Int)
    
    case api_ProductSpec(productId: Int)
    
    case api_PwdResetCode(mobile:String) //重置密码获取验证码
    
    case api_Register(account:String,password:String,captcha:String)
    
    case api_ResetPwd(mobile:String,captcha:String,newPwd:String)
    
    case api_SubmitTopicComment(topicId:Int,content:String)
    
    
    case api_Sms(type:String,mobile:String) //type = 1注册  type = 2更改验证码
    
    case api_Sms_Code(mobile:String) //验证码
    
    case api_UserUpdate(param:[String:String])
    
    case api_UserFavorite(uid:String,type:String,pageindex:String)
    
    case api_Wechat(params: [String: AnyObject]) //openId
    
    case api_WechatBind(mobile:String,captcha:String,password:String,userInfoFromWechat:AnyObject)
    
    case api_Topics(topicId:Int)
    
    case api_Topic_Products(topicId:Int)
    
    //推送消息相关
    case api_MessageMain
    
    case api_MessageList(msgType: Int, pageSize: Int, currentPage: Int)
    
    case api_MessageCount
    
    case api_MessageRead(messageId: Int, msgType: Int)
    
    case api_MessageAllRead(msgType: Int)
    
    //分享H5
    case api_H5Share(h5Url: String)
    //
    case api_Deferreddeeplink
    //领取优惠券
    case api_CouponObtain(couponId: Int)
    //用户手动绑定微信
    case api_BindWechatInfo(params: [String: AnyObject])
    //更改手机获取验证码
    case api_MobileCaptcha(mobile: String)
    //更改手机
    case api_OriginalMobile(mobile: String, captcha: String)
    //获取绑定手机验证码
    case api_NewMobileCaptcha(mobile: String)
    //绑定手机
    case api_BindMobile(mobile: String, captcha: String)
    
    case api_ProductScene(params: [String: AnyObject])
    
    case api_SceneProduct(params: [String: AnyObject])
    
    case api_ProductTag(params: [String: AnyObject])
    
    case api_TagProduct(params: [String: AnyObject])
    
    case api_ProductCategory(params: [String: AnyObject])
    
    //欣赏
    case api_UserStatistics(params: [String: AnyObject])

}

extension RequestApi:TargetType{
    //    public /// The method used for parameter encoding.
    //    var parameterEncoding: ParameterEncoding {
    //        <#code#>
    //    }
    
    public var task: Task {
        return .request
    }
    
    
    public var baseURL:URL{
        return URL(string: RequestApi.HostUrl)!
    }
    
    public var path:String{
        switch self{
        case .api_checkVersion:
            return URL_CheckVersion
        case .api_qiniu_token:
            return URL_QINIU_TOKEN
        case .api_AD:
            return URL_AD
        case .api_Category:
            return URL_category
            
        case .api_User:
            return URL_User
            
        case .api_Category_subCategory_with_image:
            return URL_category_subCategory_with_image
        case .api_Category_path_category:
            return URL_category_path_category
            
        case .api_Product_By_Category:
            return URL_producty_by_category
        case .api_Sence:
            return URL_scene
        case .api_SenceDetail:
            return URL_senceDetail
        case .api_ProductScene:
            return URL_ProductScene
        case .api_SceneProduct:
            return URL_SceneProduct
        case .api_ProductTag:
            return URL_ProductTag
        case .api_TagProduct:
            return URL_TagProduct
        case .api_ProductCategory:
            return URL_ProductCategory
            
        //Tab 第一个栏 首页 该死的那3个url
        case .api_Home_Banners:
            return URL_home_banners
        case .api_Home_Tabs:
            return URL_Home_Tabs
        case .api_Home_List:
            return URL_home_List
        case .api_floatWindow:
            return URL_floatWindow
            
        case .api_Home_BottomList:
            return URL_home_BottomList
            
        case .api_HotStyle_BottomList:
            return URL_HotStyle_BottomList
            
        case .api_SearchHot:
            return URL_Search_hot
        case .api_SearchResult:
            return URL_Search_result
        case .api_ProductDetail:
            return URL_product_detail
        case .api_ProductSpec:
            return URL_ProductSpec
        case .api_ProductAbout:
            return URL_ProductAbout
        case .api_BrandList:
            return URL_BrandList
        case .api_BrandDetail:
            return URL_BrandDetail
        case .api_ProductBrand:
            return URL_ProductBrand
        case .api_DesignerDetail:
            return URL_DesignerDetail
        case .api_productDesigner:
            return URL_ProductDesigner
        case .api_DesignerList:
            return URL_DesignerList
        case .api_TopicCommentList:
            return URL_TopicCommentList
        case .api_SubmitTopicComment:
            return URL_SubmitTopicComment
        case .api_userFeedBack:
            return URL_FeedBack
        //商品评轮列表
        case .api_ProductCommentList:
            return URL_productCommentList
        case .api_ProductGroupTop:
            return URL_ProductGroupTop
        case .api_ProductInformations:
            return URL_Product_Info
            
        case .api_ProductGroupList:
            return URL_ProductGroupList
        //购物车相关
        case .api_CartModify:
            return URL_CartModify
        case .api_UserUpdate:
            return URL_UpdateInfo
        case .api_CartAdd:
            return URL_CartAdd
        case .api_CartGet:
            return URL_CartGet
            
        case .api_CartRemove:
            return URL_CartRemove
        case .api_CartSelect:
            return URL_CartSelect
        case .api_CartUnSelect:
            return URL_CartUnSelect
        case .api_CartBottomList:
            return URL_CartBottomList
        //收藏相关
        case .api_UserFavorite:
            return URL_FavoriteList
        case .api_FavoriteProduct:
            return URL_FavoriteProduct
        case .api_FavoriteBrand:
            return URL_FavoriteBrand
        case .api_FavoriteDesigner:
            return URL_FavoriteDesigner
        case .api_FavoriteTopicComment:
            return URL_FavoriteTopicComment
        case .api_IsFavoriteProduct:
            return URL_IsFavoriteProduct
        case .api_IsFavoriteBrand:
            return URL_IsFavoriteBrand
        case .api_IsFavoriteDesigner:
            return URL_IsFavoriteDesigner
        case .api_LikeProduct:
            return URL_LikeProduct
        case .api_LikeBrand:
            return URL_LikeBrand
        case .api_LikeDesigner:
            return URL_LikeDesigner
        case .api_LikeProject:
            return URL_LikeProject
        case .api_Login:
            return URL_login
        case .api_Register:
            return URL_Register
        case .api_Sms:
            return URL_Sms
        case .api_Sms_Code:
            return URL_Sms
        case .api_Captcha:
            return URL_Captcha
        case .api_PwdResetCode:
            return URL_PwpResetCode
        case .api_Wechat:
            return URL_Wechat
        case .api_WechatBind:
            return URL_WechatBind
        case .api_ResetPwd:
            return URL_ResetPassword
        case .api_Change:
            return URL_Change
            
        case .api_AddressAdd:
            return URL_AddressAdd
        case .api_Addresslist:
            return URL_AddressList
        case .api_AddressDelete:
            return URL_AddressDelete
        case .api_AddressSetDefault:
            return URL_AddressSetDefault
        case .api_AddressEdit:
            return URL_AddressEdit
        case .api_AddressDefault:
            return URL_AddressDefault
            
        //订单相关
        case .api_OrderList:
            return URL_OrderList
        case .api_OrderStatus:
            return URL_OrderStatus
        case .api_OrderSettle:
            return URL_OrderSettle
        case .api_OrderBuyNow:
            return URL_OrderBuyNow
        case .api_OrderCreate:
            return URL_OrderCreat
        case .api_OrderCharge:
            return URL_OrderCharge
        case .api_OrderDetail:
            return URL_OrderDetail
        case .api_PayResult:
            return URL_PayResult
        case .api_OrderConfirm:
            return URL_OrderConfirm
        case .api_OrderCancel:
            return URL_OrderCancel
        case .api_OrderComment:
            return URL_OrderComment
        case .api_OederReminder:
            return URL_OrderReminder
        case .api_OrderPushComment:
            return URL_OrderPushComment
        case .api_GetRefundMoney:
            return URL_GetRefundMoney
        case .api_CreatRefund:
            return URL_CreateRefund
        case .api_GetRefundDetail:
            return URL_GetRefundDetail
        case .api_GetRefundList:
            return URL_GetRefundList
        case .api_GetRefundLog:
            return URL_GetRefundLog
        case .api_GetCancelRefund:
            return URL_CancelRefund
        case .api_EntryRefundInfo:
            return URL_EntryRefundInfo
        case .api_GetRefundProcess:
            return URL_GetRufundProcess
        case .api_Invite:
            return URL_Invite
        // 筛选
        case .Api_Screen_Main:
            return URL_ScreenMain
        case .Api_Screen_Price:
            return URL_ScreenPrice
            
        case .api_Coupons:
            return URL_Coupons
        case .api_GetCoupon:
            return URL_GetCoupon
        case .api_Topics:
            return URL_topic
        case .api_ProductsOfCoupon:
            return URL_ProductsOfCoupon
            
        case .api_Topic_Products:
            return URL_topic_product
            
        //推送消息相关
        case .api_MessageMain:
            return URL_MessageMain
            
        case .api_MessageList:
            return URL_MessageList
            
        case .api_MessageCount:
            return URL_MessageCount
            
        case .api_MessageRead:
            return URL_MessageRead
            
        case .api_MessageAllRead:
            return URL_MessageAllRead
        case .api_Logout:
            return URL_Logout
        case .api_H5Share:
            return URL_H5Share
        case .api_Deferreddeeplink:
            return URL_Deferreddeeplink
        case .api_CouponObtain:
            return URL_CouponObtain
        case .api_BindWechatInfo:
            return URL_BindWechatInfo
        case .api_MobileCaptcha:
            return URL_MobileCaptcha
        case .api_OriginalMobile:
            return URL_OriginalMobile
        case .api_NewMobileCaptcha:
            return URL_NewMobileCaptcha
        case .api_BindMobile:
            return URL_BindMobile
        case .api_LoginCaptcha:
            return URL_LoginCaptcha
        case .api_LoginByCaptcha:
            return URL_LoginByCaptcha
        case .api_UserStatistics:
            return URL_UserStatistics

        }
    }
    
    public var method:Moya.Method{
        switch self {
        case .api_Addresslist, .api_BrandList, .api_Home_Banners, .api_LikeBrand, .api_LikeProduct, .api_LikeDesigner, .api_IsFavoriteProduct, .api_IsFavoriteBrand, .api_IsFavoriteDesigner, .api_ProductDetail, .api_ProductSpec, .api_OrderList,.api_CartGet, .api_AddressDefault, .api_OrderSettle, .api_BrandDetail, .api_ProductBrand, .api_DesignerDetail, .api_productDesigner, .api_Category, .api_PayResult, .api_OrderDetail , .api_Product_By_Category , .api_Coupons , .api_Topics, .api_Topic_Products, .api_Home_List, .api_Home_BottomList
        ,
             .api_SearchHot, .api_SearchResult,
             .api_DesignerList,
             .api_Category_subCategory_with_image,
             .api_Category_path_category,
             .api_AD,
             .api_HotStyle_BottomList,
             .api_TopicCommentList,
             .api_ProductCommentList,
             .api_OrderComment,
             .api_ProductAbout,
             .api_checkVersion,
             .api_MessageMain,
             .api_MessageList,
             .api_MessageCount,
             .api_CartBottomList,
             .api_ProductGroupTop,
             .api_ProductInformations,
             .api_ProductGroupList,
             .api_ProductsOfCoupon,
             .Api_Screen_Main,
             .Api_Screen_Price,
             .api_Deferreddeeplink,
             .api_User,
             .api_ProductScene,
             .api_SceneProduct,
             .api_ProductTag,
             .api_TagProduct,
             .api_Home_Tabs,
             .api_ProductCategory,
             .api_UserStatistics,
             .api_GetRefundMoney,
             .api_GetRefundDetail,
             .api_GetRefundList,
             .api_GetRefundLog,
             .api_floatWindow,
             .api_GetRefundProcess:
            return .get
            
        default:
            return .post
        }
        
    }
    
    
    
    public var parameters:[String: Any]?{
        var params = [String: Any]()
        
        switch self{
        case let .api_qiniu_token(qiniuKey,bucket):
            params = ["key": qiniuKey,"bucket": bucket]
        case let .api_Category(categoryId):
            params = ["categoryId":categoryId]
        case let .api_Category_subCategory_with_image(categoryId):
            params = ["categoryId":categoryId]
        case let .api_Category_path_category(categoryId):
            params = ["categoryId":categoryId]
        case let .api_SenceDetail(sceneid,uid):
            params = ["scene_id":sceneid,"uid":uid]
        case let .api_Register(account,password,code):
            params = ["mobile":account,"password":password,"captcha":code]
        case let .api_Login(account,password):
            params = ["mobile":account,"password":password]
        case let .api_BrandDetail(brandid):
            params = ["brandId": brandid]
        case let .api_ProductBrand(param):
            params = param
        case let .api_DesignerDetail(designerId):
            params = ["designerId": designerId]
        case let .api_productDesigner(designerId, pageSize, currentPage):
            params = ["designerId": designerId, "pageSize": pageSize, "currentPage": currentPage]
        case let .api_ProductDetail(productId):
            params = ["productId":productId]
        case let .api_ProductAbout(param):
            params = param
            
        case let .api_ProductGroupTop(groupId):
            params = ["groupId":groupId]
            
        case let .api_ProductInformations(groupId):
            params = ["groupId":groupId]
            
        case let .api_ProductGroupList(param):
            params = param
            
        case let .api_userFeedBack(param):
            params = param
        case let .api_ProductSpec(productId):
            params = ["productId":productId]
        case let .api_TopicCommentList(pageSize,currentPage,topicId, lastId):
            params = ["pageSize": pageSize, "currentPage": currentPage, "topicId": topicId, "lastId": lastId]
        //商品评论
        case let .api_ProductCommentList(pageSize,currentPage,productId):
            params = ["pageSize": pageSize, "currentPage": currentPage, "productId": productId]
        case let .api_SubmitTopicComment(topicId,content):
            params =  ["topicId":topicId,"content":content]
        case let .api_UserUpdate(param):
            params =  param
        case let .api_UserFavorite(uid,type,pageindex):
            params =  ["uid":uid,"type":type,"pageindex":pageindex]
            
        case let .api_CartModify(shoppingCartId, productQty):
            params =  ["shoppingCartId": shoppingCartId, "productQty": productQty]
        case let .api_CartRemove(shoppingCartId):
            params =  ["shoppingCartIds":shoppingCartId]
        case let .api_CartAdd(productId, productQty):
            params =  ["productId": productId, "productQty": productQty]
        case let .api_CartSelect(shoppingCartIds):
            params = ["shoppingCartIds": shoppingCartIds]
        case let .api_CartUnSelect(shoppingCartIds):
            params = ["shoppingCartIds": shoppingCartIds]
            
        case let .api_CartBottomList(pageSize,currentPage):
            
            params = ["pageSize": pageSize, "currentPage": currentPage]
            
        case let .api_Change(param):
            params = param
        //用户喜欢相关
        case let .api_FavoriteProduct(productId):
            params = ["productId":productId]
            
        case let .api_LikeProject(topicId):
            params = ["id":topicId]
            
        case let .api_FavoriteBrand(brandId):
            params = ["brandId":brandId]
        case let .api_FavoriteDesigner(designerId):
            params = ["designerId":designerId]
        case let .api_IsFavoriteProduct(productId):
            params = ["productId":productId]
        case let .api_IsFavoriteBrand(brandId):
            params = ["brandId":brandId]
        case let .api_FavoriteTopicComment(commentId):
            params = ["id": commentId]
        case let .api_IsFavoriteDesigner(designerId):
            params = ["designerId":designerId]
            
        case let .api_Sms(type,mobile):
            params =  ["type":type,"mobile":mobile]
        case let .api_Sms_Code(mobile):
            params =  ["mobile":mobile]
        case let .api_Captcha(mobile):
            params =  ["mobile":mobile]
        case let .api_LoginCaptcha(mobile):
            params =  ["mobile":mobile]
        case let .api_LoginByCaptcha(mobile, captcha):
            params =  ["mobile":mobile, "captcha": captcha]
        case let .api_PwdResetCode(mobile):
            params =  ["mobile":mobile]
        case let .api_Wechat(param):
            params = param
        case let .api_WechatBind(mobile,captcha,password,userInfoFromWechat):
            params =  ["mobile":mobile,"captcha":captcha,"password":password,"userInfoFromWechat":userInfoFromWechat]
        case let .api_ResetPwd(mobile, code, password):
            params =  ["mobile":mobile,"captcha":code,"newPwd":password]
        case let .api_AddressAdd(receiverName, provinceId, cityId, countyId, addressDetail, receiverMobile, isDefault):
            params =  ["receiverName": receiverName, "provinceId": provinceId, "cityId": cityId, "countyId":countyId, "addressDetail": addressDetail, "receiverMobile": receiverMobile, "isDefault": isDefault]
        case .api_Addresslist:
            break
        case let .api_AddressDelete(id):
            params =  ["id":id]
        case let .api_AddressSetDefault(id):
            params = ["id":id]
        case let .api_AddressEdit(id, receiverName, provinceId, cityId, countyId, addressDetail, receiverMobile, isDefault):
            params = ["id": id, "receiverName": receiverName, "provinceId": provinceId, "cityId": cityId, "countyId":countyId, "addressDetail": addressDetail, "receiverMobile": receiverMobile, "isDefault": isDefault]
            
        //订单相关
        case let .api_OrderList(param):
            params =  param ?? ["": AnyObject.self]
            
        case let .api_OrderStatus(uid,order_id,status):
            params =  ["uid":uid,"order_id":order_id,"status":status]
        case let .api_OrderCreate(param):
            params = param
        case let .api_OrderCharge(param):
            params = param
        case let .api_OrderBuyNow(productId, productQty):
            params = ["productId": productId, "productQty": productQty]
        case let .api_PayResult(orderCode):
            params = ["orderCode": orderCode]
        case let .api_OrderConfirm(orderCode):
            params = ["orderCode": orderCode]
        case let .api_OrderCancel(orderCode):
            params = ["orderCode": orderCode]
        case let .api_OrderDetail(OrderCode):
            params =  ["orderCode":OrderCode]
            
        case let .api_OrderComment(OrderCode):
            params =  ["orderCode":OrderCode]
        case let .api_OederReminder(orderCode):
             params =  ["orderCode":orderCode]
        case let .api_OrderPushComment(param):
            params = param!
        case let .api_GetRefundMoney(saleOrderItemId,isWholeRefund):
            
            params = ["saleOrderItemId":saleOrderItemId]
            if let isWholeRefund = isWholeRefund {
                
                params["isWholeRefund"] = isWholeRefund
                
            }
            
        case let .api_GetRefundLog(orderCode, saleOrderItemRefundId):
            if let orderCode = orderCode {
                
                params = ["orderCode":orderCode]
                
            }else if let saleOrderItemRefundId = saleOrderItemRefundId{
                
                params = ["saleOrderItemRefundId":saleOrderItemRefundId]
                
            }
            
        case let .api_CreatRefund(param):
            params = param
            
        case let .api_GetRefundDetail(refundId):
            params = ["saleOrderItemRefundId":refundId]
        case let .api_GetRefundList(param):
            
            params = param
            
        case let .api_GetRefundProcess(saleOrderItemRefundId):
            params = ["saleOrderItemRefundId":saleOrderItemRefundId]
            
        case let .api_GetCancelRefund(saleOrderItemRefundId):
            params = ["saleOrderItemRefundId":saleOrderItemRefundId]
            
        case let .api_EntryRefundInfo(param):
            params = param
            
        case .api_Home_Banners():
            params =  ["pageType":1]
        case .api_Home_Tabs():
            params =  ["pageId":1]
        case let.api_checkVersion(param):
            params = param!
            
        case let .api_Home_List(param):
            params = param!
            
        case let .api_Home_BottomList(param):
            params = param!
        case let .api_HotStyle_BottomList(param):
            params = param!
        // 筛选
        case .Api_Screen_Main:
            break
        case let .Api_Screen_Price(categoryId):
            params = ["categoryId":categoryId]
        case .api_DesignerList:
            break
        case .api_User:
            break
        case let .api_Product_By_Category(param): //查看分类下商品 asc 0 降序 当前页 showCount  sortBy 1 categoryId
            params = param
            break
            
        //            优惠券
        case let .api_Coupons(param):
            params =  param!
        case let .api_ProductsOfCoupon(pageSize, currentPage, sortColumn, sortType, id):
            params = ["pageSize": pageSize, "currentPage": currentPage, "id": id, "sortColumn": sortColumn, "sortType":sortType]
        case let .api_GetCoupon(redemptionCode):
            params = ["redemptionCode": redemptionCode]
        //            专题
        case let .api_Topics(topicId):
            params =  ["topicId": topicId]
        //            专题商品
        case let .api_Topic_Products(topicId):
            params =  ["topicId": topicId]
            
        case let .api_SearchResult(param):
            params =  param
            
        //推送消息
        case let .api_MessageList(msgType, pageSize, currentPage):
            params = ["msgType": msgType, "pageSize": pageSize, "currentPage": currentPage]
        case let .api_MessageRead(messageId, msgType):
            params = ["messageId": messageId, "msgType": msgType]
        case let .api_MessageAllRead(msgType):
            params = ["msgType": msgType]
        case let .api_H5Share(h5Url):
            params = ["h5Url": h5Url]
        case let .api_CouponObtain(couponId):
            params = ["couponId": couponId]
        case let .api_BindWechatInfo(param):
            params = param
        case let .api_MobileCaptcha(mobile):
            params = ["mobile": mobile]
        case let .api_OriginalMobile(mobile, captcha):
            params = ["mobile": mobile, "captcha": captcha]
        case let .api_NewMobileCaptcha(mobile):
            params = ["mobile": mobile]
        case let .api_BindMobile(mobile, captcha):
            params = ["mobile": mobile, "captcha": captcha]
        case let .api_ProductScene(param):
            params = param
        case let .api_SceneProduct(param):
            params = param
        case let .api_ProductTag(param):
            params = param
        case let .api_TagProduct(param):
            params = param
        case let .api_ProductCategory(param):
            params = param
        // 欣赏
        case let .api_UserStatistics(param):
            params = param

        default:
            break
            
        }

        params =   ["paramJson":Untils.JSONStringify(params as AnyObject)]
        
        return params
    }

    
    /// 返回""空串的话代表需要在回调函数里面自己提示
    public var endSuccessMsg:String?{
        switch self {
        case .api_Login:
            return "登录成功"
        case .api_Register:
            return "注册成功"
        case .api_SubmitTopicComment:
            return "评论成功"
        case .api_Sms:
            return "验证码发送成功"
        case .api_AddressAdd:
            return ""
        case .api_CartAdd:
            return "添加购物车成功"
        case .api_OrderConfirm:
            return "确认收货成功"
//        case .api_OederReminder:
//            return ""
        case .api_OrderCancel:
            return "取消订单成功"
        case .api_ResetPwd:
            return "修改密码成功"
        case .api_userFeedBack:
            return "感谢您的反馈"
        default:
            return ""
        }
    }
    
    //  单元测试用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var parameterEncoding: ParameterEncoding {
        
        return URLEncoding.default
        
    }
    
    public func headers() -> [String: String] {
        var assigned: [String: String] = [
            "X-WOW-APP-CH":"2",

        ]
        assigned += ["User-Agent": getUserAgent()]
        return assigned
    }
    func getUserAgent() -> String {
        let sysName = UIDevice.current.systemName //获取系统名称 例如：iPhone OS
        let sysVersion = UIDevice.current.systemVersion //获取系统版本 例如：9.2
        let deviceModel = UIDevice.current.model //获取设备的型号 例如：iPhone
        let infoDic = Bundle.main.infoDictionary
        let appVersion = infoDic?["CFBundleShortVersionString"] ?? ""// 获取App的版本
        let user_Agent = String(format: "apple/%@/%@/%@/%@", deviceModel, sysName, sysVersion, appVersion as! String)
        return user_Agent
    }
}

