//
//  AppDelegate.h
//  大众点评
//
//  Created by qianfeng on 3/28/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPAPI;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (readonly, nonatomic) DPAPI *dpapi;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;


+ (AppDelegate *)instance;

@end

