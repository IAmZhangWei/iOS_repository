//
//  MainPageModel.m
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "MainPageModel.h"

@implementation MainPageModel

@synthesize photo_url = _photo_url;
@synthesize name = _name;
@synthesize address = _address;

- (void)dealloc
{
    self.photo_url = nil;
    self.name = nil;
    self.address = nil;
    [super dealloc];
}
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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.photo_url = [aDecoder decodeObjectForKey:@"photo_url"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.avg_price = [aDecoder decodeIntegerForKey:@"avg_price"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.photo_url forKey:@"photo_url"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.avg_price forKey:@"avg_price"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

@end
