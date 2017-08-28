//
//  UIViewController+PV.m
//  Tab
//
//  Created by 陈旭 on 2017/8/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

#import "UIViewController+PV.h"
#import <objc/runtime.h>
@implementation UIViewController (PV)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
        Method swizzledMethod = class_getInstanceMethod([self class], @selector(cx_viewWillAppear:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });

}

-(void)cx_viewWillAppear:(BOOL)animated {

//    [self cx_viewWillAppear:animated];
    NSLog(@"aaaaaa");
}
@end
