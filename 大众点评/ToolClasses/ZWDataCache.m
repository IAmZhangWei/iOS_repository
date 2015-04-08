//
//  ZWDataCache.m
//  大众点评
//
//  Created by qianfeng on 15/4/8.
//  Copyright (c) 2015年 张维. All rights reserved.
//

#import "ZWDataCache.h"
#import "NSString+Hashing.h"

@implementation ZWDataCache

static ZWDataCache *cache = nil;
+ (ZWDataCache *)sharedDataCache {
    @synchronized (self) {
        if (cache == nil) {
            cache = [[ZWDataCache alloc] init];
        }
    }
    return cache;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (cache == nil) {
        cache = [super allocWithZone:zone];
    }
    return cache;
}

+ (void)releaseDataCache {
    if (cache != nil) {
        cache = nil;
    }
}

- (void)saveData:(NSData *)data withUrlString:(NSString *)url {
    NSString *path = [NSString stringWithFormat:@"%@/Documents/DataCache/", NSHomeDirectory()];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *str = [url MD5Hash];
    
    BOOL isSuc = [data writeToFile:[NSString stringWithFormat:@"%@/%@", path, str] atomically:YES];
    
    if (isSuc) {
        NSLog(@"存储成功!");
    } else {
        NSLog(@"存储失败!");
    }
}

- (NSData *)getDataWithUrlString:(NSString *)url {
    NSString *path = [NSString stringWithFormat:@"%@/Documents/DataCache/%@", NSHomeDirectory(), [url MD5Hash]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = [fileManager fileExistsAtPath:path];
    
    if (!isExist) {
        return nil;
    }
    
    NSTimeInterval timeInte = [[NSDate date] timeIntervalSinceDate:[self getmodifyTime:path]];
    
    if (timeInte >= 60) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (NSDate *)getmodifyTime:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDictionary *dic = [fileManager attributesOfItemAtPath:path error:nil];
    
    return dic[@"NSFileModificationDate"];
    
    return nil;
}



@end
