//
//  UIControl+AcceptEvent.m
//  Tab
//
//  Created by 陈旭 on 2017/8/15.
//  Copyright © 2017年 陈旭. All rights reserved.
//

#import "UIControl+AcceptEvent.h"
#import <objc/runtime.h>
@implementation UIControl (AcceptEvent)
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";  // const void *key 属性名 (根据key获取关联的对象)

static const char *UIControl_cx_key = "UIControl_cx_key";  // const void *key 属性名 (根据key获取关联的对象)

- (NSTimeInterval)acceptEventInterval {
        // get 到 UIControl_acceptEventInterval 相关联的对象的值
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}


-(void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
        // set 到 UIControl_acceptEventInterval 的key 的值  ，值为acceptEventInterval
        // @()用法
        // 在 Objective-C 中我们可以用 @”foo” 来创建一个 NSString 常量，看起来似乎平淡无奇。
        // 但 它背后其实比想象的精彩，@ 可以被理解成一个特殊的宏，其接受一个 C 字符串作为参数，也可写作 @(“foo”)
        // 当 acceptEventInterval 为基本类型时，  不是id 类型，则需用 用 @（） 包装一下
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 一般类似 的属性 get set 方法， 则是 这种方式，是因为 在 子类里 或者父类里 声明一个属性，会自动的声明 get set 方法 以及 _name 实例变量，而在分类里面 是不能添加变量的， 此时使用runtime 可以添加变量 ，
//- (void) setName:(NSString *)name
//{
//    _name = name;
//}
//
//- (NSString *) name
//{
//    return _name;
//}

-(NSString *)cx_key {

    return [objc_getAssociatedObject(self, UIControl_cx_key) stringValue];

}

-(void)setCx_key:(NSString *)cx_key{

    objc_setAssociatedObject(self, UIControl_cx_key, cx_key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
     //  只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method b = class_getInstanceMethod(self, @selector(wow_sendAction:to:forEvent:));
        
        
        method_exchangeImplementations(a, b);
    });


}
-(void)wow_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{

    if (self.acceptEventInterval > 0) {
        if (self.userInteractionEnabled) {
            [self wow_sendAction:action to:target forEvent:event];
        }
        self.userInteractionEnabled = NO;
        // 延时调用， 时间过之后， 把状态改为 YES
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setUserInteractionEnabled:YES];
        });
        
    }else {
        [self wow_sendAction:action to:target forEvent:event];
    }

}
@end
