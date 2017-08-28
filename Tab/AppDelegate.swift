//
//  AppDelegate.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/25.
//  Copyright © 2017年 陈旭. All rights reserved.
//
public extension UIStoryboard {
    /**
     根据stroyboard名称返回初始控制器
     
     - parameter name: 名称/Users/chenxu/Desktop/Tab/TabTests
     
     - returns: 初始控制器
     */
    class func initialViewController(_ name: String) -> UIViewController {
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateInitialViewController()!
    }
    
    /**
     根据stroyboard名称和标示符返回对应的控制器
     
     - parameter name:       名称
     - parameter identifier: 标示符
     
     - returns: 对应的控制器
     */
    class func initialViewController(_ name: String, identifier: String) -> UIViewController
    {
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
    
    
    class func initNavVC(_ name: String, identifier: String) -> UINavigationController {
        let sb      = UIStoryboard(name: name, bundle: nil)
        let nav_vc  = UINavigationController.init(rootViewController: sb.instantiateViewController(withIdentifier: identifier))
        
        return nav_vc
    }
    
}
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let lb = YYFPSLabel()
//        lb.frame = CGRect.init(x: MGScreenWidth/2, y: MGScreenHeight/2, width: 100, height: 100)
////        lb.backgroundColor = UIColor.red
//    
//        self.window?.addSubview(lb)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

