//
//  MainPageModel.m
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "MainPageModel.h"

@implementation MainPageModel

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

+ (MainPageModel *)mainPageModelWithDic:(NSDictionary *)dic {
    return [[[MainPageModel alloc] initWithDic:dic] autorelease];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
