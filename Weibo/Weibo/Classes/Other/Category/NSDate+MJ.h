//
//  NSDate+MJ.h
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MJ)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  获得当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end