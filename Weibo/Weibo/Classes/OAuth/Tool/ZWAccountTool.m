//
//  ZWAccountTool.m
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWAccountTool.h"
#import "ZWAccount.h"

#define ZWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation ZWAccountTool

+ (void)saveAccount:(ZWAccount *)account {
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:ZWAccountFile];
}

+ (ZWAccount *)account {
    //取出账号
    ZWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZWAccountFile];
    
    //判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    } else {
        return nil;//过期
    }
}

@end
