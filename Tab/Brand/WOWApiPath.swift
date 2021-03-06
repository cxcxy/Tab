//
//  WOWApiPath.swift
//  Wow
//
//  Created by 王云鹏 on 16/3/18.
//  Copyright © 2016年 wowdsgn. All rights reserved.
//

import Foundation

//Host
//王云鹏自己的本机 10.0.23.67        127.0.0.1+                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
//测服地址 http://api.dev.wowdsgn.com


//#if WOWDEBUG

let WOWShareUrl                         = "m.wowdsgn.com" // 正式服务器 分享地址
//let WOWShareUrl                         = "http://10.0.60.121:7070"// 测试服务器分享地址

    var BaseUrl = "http://10.0.60.60:8080/" //内网开发

//   let BaseUrl = "http://10.0.60.91:8080/"
//  let BaseUrl = "https://wowdsgn.iok.la" //外网访问内网也可以的地址
//   let BaseUrl = "https://mobile-api.wowdsgn.com/" //外网开发685872
//  let BaseUrl = "https://mobile-api.stg.wowdsgn.com/" //内网开发

let urlItunes = "https://itunes.apple.com/cn/app/jian-jiao-she-ji/id1110300308?mt=8" // Appstore 链接

//#else
//   let BaseUrl = "https://openapi.wowdsgn.com/v1/" //外网地址
//#endif

/****************************API_URL接口**********************************/
let URL_CheckVersion                    = "v1/version/check" 

//1.app首页
let URL_AD                              = "v2/page/startupimg"
let URL_category                        = "v1/category/sub-category"
let URL_producty_by_category            = "/v1/product/category/products"       //分类列表产品
let URL_category_subCategory_with_image = "v1/category/img-category"
let URL_category_path_category          = "v1/category/path-category"

let URL_ProductCategory         = "/v1/product/category"
let URL_floatWindow             = "v1/page/floatingWindow"             //首页浮窗

let URL_scene                   = "v1/scene"

let URL_senceDetail             = "v1/scene/detail"

let URL_ProductScene            = "v1/product/scene"  //场景列表

let URL_SceneProduct            = "v1/product/scene/products" //场景详情页产品

let URL_ProductTag              = "v1/product/tag"      //标签列表

let URL_TagProduct              = "v1/product/tag/products"       //标签详情页产品


//1.1 专题
let URL_topic                   = "v3/topic"
let URL_topic_product           = "v2/topic/product"            //导购专题产品列表


let URL_Product_Info            = "v1/product/informations"       // 商品新版接口

//***********2.商店************
//2.1首页

let URL_Home_Tabs               = "v1/page/tabs"
let URL_home_banners            = "v1/page/banners"    //1.1首页 查看首页Banner
let URL_home_scenes             = "v1/page/scenes"     //1.2首页 查看首页场景
let URL_home_List               = "v2/page"     // 首页 全新场景
let URL_home_BottomList         = "v2/product/recommend"     //首页 底部列表
let URL_HotStyle_BottomList     = "v1/topic/topics"         // 精选页底部列表
let URL_Search_hot              = "v1/product/search/hot-keywords"  //热门搜索

let URL_Search_result           = "v1/product/search"           //搜索结果


//2.3商品详情
let URL_product_detail          = "v2/product"
//2.4发表评论
let URL_SubmitTopicComment           = "v1/topic/comments"
//2.5评论列表
let URL_TopicCommentList             = "v1/topic/comments"
//商品评论列表
let URL_productCommentList             = "v1/product/comments/list"
//点赞评论
let URL_FavoriteTopicComment        = "v1/user/topic-comment/favorite"

let URL_ProductSpec             = "v2/product/spec"    //选择产品颜色规格

//相关产品
let URL_ProductAbout            = "v1/product/relateds"

let URL_ProductGroupTop         = "v1/product/group"

let URL_ProductGroupList        = "v1/product/group/products"      //产品组列表

//2.6收藏
let URL_IsFavoriteProduct       = "v1/user/product/is-favorite"   //是否喜欢某个单品

let URL_IsFavoriteBrand         = "v1/user/brand/is-favorite"      //是否喜欢某个品牌

let URL_IsFavoriteDesigner      = "v1/user/designer/is-favorite"      //是否喜欢某个品牌

let URL_FavoriteProduct         = "v1/user/product/favorite"   //收藏单品

let URL_FavoriteBrand           = "v1/user/brand/favorite"   //收藏单品

let URL_FavoriteDesigner        = "v1/user/designer/favorite"   //收藏单品

let URL_BrandList               = "v1/brand/list"

let URL_BrandDetail             = "v1/brand/detail"

let URL_ProductBrand            = "v2/product/brand"                //查询品牌产品





let URL_LikeProduct             = "v1/user/product/favorite-list"    //喜欢的品牌列表

let URL_LikeDesigner            = "v1/user/designer/favorite-list"    //喜欢的品牌列表

let URL_LikeBrand               = "v1/user/brand/favorite-list"    //喜欢的品牌列表

let URL_LikeProject            = "v1/user/topic/favorite"    //点赞专题

let URL_DesignerList            = "v1/designer/designerList"    //设计师列表

let URL_DesignerDetail          = "v1/designer/detail"         //设计师详情

let URL_ProductDesigner         = "v2/product/designer"            //设计师产品


//*********************4.购物车**********
// tag 为0 的时候 自增  为1的时候覆盖掉
let URL_CartModify               = "v1/cart/modify"

let URL_CartRemove               = "v1/cart/remove" //删除购物车商品

let URL_CartAdd                  = "v1/cart/add"        //添加购物车

let URL_CartGet                  = "v1/cart/get"        //查询购物车列表

let URL_CartSelect              = "v1/cart/select"     //选中购物车商品

let URL_CartUnSelect            = "v1/cart/unselect"   //取消选中购物车商品

let URL_CartBottomList          = "v1/cart/recommend-products" // 无购物车，显示热门推荐列表
//订单相关
let URL_OrderSettle             = "v3/order/settle"            //查询订单内的物品

let URL_OrderBuyNow             = "v3/order/settleBuyNow"             //立即购买查询信息

let URL_OrderCreat              = "v3/order/create"           //创建订单


let URL_OrderCharge             = "v1/pay/charge"             //获取支付交易凭证

let URL_OrderDetail              = "v1/order/getDetail"           //订单详情


let URL_PayResult               = "v1/pay/payResult"          //查询支付结果

let URL_OrderConfirm            = "v1/order/confirm"           //确认收货


let URL_OrderCancel             = "v1/order/cancel"           //取消订单

let URL_OrderComment            = "v1/order/orderItem/unComment"           //订单评论

let URL_OrderReminder           = "v1/order/reminder"           // 催订单



let URL_OrderPushComment        = "v1/order/comment"
let URL_GetRefundMoney          = "v1/order/refund/prepare"  // 获取退换货单最大可申请金额接口
let URL_CreateRefund            = "v1/order/refund/create" // 创建退换货单
let URL_GetRefundDetail         = "v1/order/refund/detail" //获取 售后详情
let URL_GetRefundList           = "v1/order/refund/list" // 获取退换货列表
let URL_GetRefundLog            = "v1/order/refund/log" // 获取退换货单操作日志
let URL_GetRufundProcess        = "v1/order/refund/process" // 获取退款单钱款流向
let URL_CancelRefund            = "v1/order/refund/cancel" // 撤销申请
let URL_EntryRefundInfo         = "v1/order/refund/delivery" // 用户录入退换货单物流信息

//5.个人中心
let URL_UpdateInfo              = "v1/usermongo/userupdate"
let URL_FavoriteList            = "v1/like/get"
let URL_User                    = "v1/user"
let URL_Invite                  = "v1/articleinfo"
let URL_QINIU_TOKEN             = "v1/qiniutoken"

//推送消息
let URL_MessageMain             = "v1/message/messageMain"
let URL_MessageList             = "v1/message/messageList"
let URL_MessageCount            = "v1/message/unReadMessageCount"
let URL_MessageRead             = "v1/message/messageRead"
let URL_MessageAllRead          = "v1/message/messageAllRead"

//6.app 登录注册
let URL_Register                = "v1/user/register"
let URL_login                   = "v1/session/login"
let URL_Sms                     = "v1/user/captcha/register"
let URL_ResetPassword           = "v1/user/reset-password"
let URL_Wechat                  = "v2/session/login/wechat"          //微信登录
let URL_WechatBind              = "v1/user/wechat-bind"              //绑定微信
let URL_Logout                  = "v1/session/logout"                //登出
let URL_Captcha                 = "v1/user/captcha/wechat-bind"      //微信绑定获取验证码
let URL_PwpResetCode            = "v1/user/captcha/pwd-reset"        //重置密码获取验证码
let URL_Change                  = "v1/user/change"                   //修改用户信息
let URL_Coupons                 = "v1/user/coupons"                //用户优惠券列表
let URL_GetCoupon               = "v1/user/getCouponByRedemptionCode"     //获取优惠券
let URL_ProductsOfCoupon        = "v1/user/productsOfcoupon"           //优惠券可用商品
let URL_FeedBack                = "v1/feedback"
let URL_BindWechatInfo          = "v1/user/bindWechatInfo"          //用户手动绑定微信
let URL_MobileCaptcha           = "v1/user/sendOriginalMobileCaptcha"   //更改手机获取验证码
let URL_OriginalMobile          = "v1/user/checkOriginalMobileAndCaptcha"   //更改手机
let URL_NewMobileCaptcha        = "v1/user/sendNewMobileCaptcha"            //获取绑定手机验证码
let URL_BindMobile              = "v1/user/changeBindedMobile"              //绑定手机
let URL_LoginCaptcha            = "v1/user/sendLoginCaptcha"                //登录验证码
let URL_LoginByCaptcha          = "v1/session/loginByCaptcha"               //短信登录

//7.地址
let URL_AddressAdd              = "v1/user/shippinginfo/create"   //添加收货地址
let URL_AddressList             = "v1/user/shippinginfo/list"
let URL_AddressDelete           = "v1/user/shippinginfo/delete"
let URL_AddressSetDefault       = "v1/user/shippinginfo/set-default" //设为默认收货地址
let URL_AddressDefault          = "v1/user/shippinginfo/default"   //查询默认收货地址
let URL_AddressEdit             = "v1/user/shippinginfo/update"    //编辑收货地址

let URL_OrderList               = "v1/order/get"

let URL_OrderStatus             = "v1/order/setstatus" //状态客户端操作之后加上去

// 8.筛选页面

let URL_ScreenMain              = "v1/product/filter-conditions"
let URL_ScreenPrice             = "category/price-ranges"
let URL_ScreenResult            = "product/condition"

//获取H5分享参数
let URL_H5Share                 = "v1/h5Page/shareInfo"

//v1/deferreddeeplink
let URL_Deferreddeeplink        = "v1/deferreddeeplink"
//领取优惠券                                                                                                                                                                
let URL_CouponObtain            = "v1/user/coupon/obtain"

//欣赏

let URL_UserStatistics          = "v1/instagram/user/statistics"        //作品统计


