//
//  ZWDataCache.h
//  大众点评
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 张维. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWDataCache : NSObject

+ (ZWDataCache *)sharedDataCache;
+ (void)releaseDataCache;//释放对象

//存数据
- (void)saveData:(NSData *)data withUrlString:(NSString *)url;
//取数据
- (NSData *)getDataWithUrlString:(NSString *)url;

@end
