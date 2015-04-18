//
//  ZWAccount.m
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWAccount.h"

@implementation ZWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDic:dict];
}

- (instancetype)initWithDic:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调用
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}


@end
