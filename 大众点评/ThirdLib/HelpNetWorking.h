//
//  HelpNetWorking.h
//  AFN封装
//
//  Created by 许广超 on 15-3-20.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProvinceResult;
@class Car;
@interface HelpNetWorking : NSObject

//+ (NSURLSessionDataTask *)getProvinceDataWithBlock:(void (^)(ProvinceResult *provinceResult, NSError *error))block;

+ (NSURLSessionDataTask *)getCarDataWithBlock:(void (^)(Car *car, NSError *error))block;

@end
