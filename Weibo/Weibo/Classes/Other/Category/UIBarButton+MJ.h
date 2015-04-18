//
//  UIBarButton+MJ.h
//  Weibo
//
//  Created by qianfeng on 15/4/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end