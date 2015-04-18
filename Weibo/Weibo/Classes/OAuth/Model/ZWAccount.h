//
//  ZWAccount.h
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime;//账号的过期时间
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDic:(NSDictionary *)dict;

@end
