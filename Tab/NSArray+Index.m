//
//  NSArray+Index.m
//  Tab
//
//  Created by 陈旭 on 2017/8/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

#import "NSArray+Index.h"
#import <objc/runtime.h>
@implementation NSArray (Index)



/* 不推荐类似的方法，因为这会hook住系统的objectAtIndex 方法， 而系统本身在一些其他的操作方面， 也会调用这个方法，所以会一定程度上的消耗性能， 目前的做法是写一个类目， 然后，我们在需要用的地方， 去用就好*/
//+(void)load{
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:));
//    Method toMethod   = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(cx_objectAtIndex:));
//    
//    method_exchangeImplementations(fromMethod, toMethod);
//    
//}
//
//-(void)cx_objectAtIndex:(NSUInteger)index {
//    if (self.count - 1 < index) {
//        @try {
//            return [self cx_objectAtIndex:index];
//        } @catch (NSException *exception) {
//            // 在崩溃后会打印崩溃信息，方便我们调试。
//            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
//            NSLog(@"%@", [exception callStackSymbols]);
//
//
//        } @finally {
//            
//        }
//    }else{
//        return [self cx_objectAtIndex:index];
//    }
//
//}

@end
