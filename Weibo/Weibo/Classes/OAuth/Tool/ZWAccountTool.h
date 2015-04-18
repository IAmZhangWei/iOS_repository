//
//  ZWAccountTool.h
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZWAccount;

@interface ZWAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(ZWAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (ZWAccount *)account;

@end
