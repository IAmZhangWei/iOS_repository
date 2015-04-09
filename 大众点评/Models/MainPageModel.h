//
//  MainPageModel.h
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPageModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *photo_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger avg_price;
@property (nonatomic, copy) NSString *address;

+ (MainPageModel *)mainPageModelWithDic:(NSDictionary *)dic;


@end
