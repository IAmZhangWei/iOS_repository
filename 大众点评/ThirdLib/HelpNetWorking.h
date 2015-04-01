//
//  HelpNetWorking.h
//  AFN封装
//
//  Created by 许广超 on 15-3-20.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpNetWorking : NSObject

+ (NSURLSessionDataTask *)getCarDataWithBlock:(void (^)(NSObject *car, NSError *error))block;

@end
