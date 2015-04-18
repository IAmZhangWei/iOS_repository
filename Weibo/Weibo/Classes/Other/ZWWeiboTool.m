//
//  ZWWeiboTool.m
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWWeiboTool.h"
#import "ZWTabBarController.h"
#import "ZWNewfeatureViewController.h"

@implementation ZWWeiboTool

+ (void)chooseRootController {
    
    NSString *key = @"CFBundleVersion";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZWTabBarController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZWNewfeatureViewController alloc] init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
