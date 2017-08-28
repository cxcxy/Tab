//
//  UIControl+AcceptEvent.h
//  Tab
//
//  Created by 陈旭 on 2017/8/15.
//  Copyright © 2017年 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AcceptEvent)

@property (nonatomic, assign) NSTimeInterval acceptEventInterval;//添加点击事件的间隔时间

//@property (nonatomic, assign) BOOL ignoreEvent;//       是否忽略点击事件  默认为 false

@property (nonatomic,copy,nonnull) NSString *cx_key;

@end

