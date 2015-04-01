//
//  HelpNetWorking.m
//  AFN封装
//
//  Created by 许广超 on 15-3-20.
//  Copyright (c) 2015年 QF. All rights reserved.
//

/*
 asi它是基于BSD【c语言】协议来封装的，比较底层，实际上asi比afn性能好。
 
 afn是基于NSURLConnection和NSURLSession来封装的，性能稍微差一些，但是里面大量的使用了主流的block
 
 asi性能好，但是现在公司越来越多的使用afn，是因为asi从11年底就没有再更新【作者放弃维护】，而afn一直在更新中，未来afn一定会完全取代asi。
 */


#import "HelpNetWorking.h"
#import "AFAppDotNetAPIClient.h"

#define APPKEY  @"9898678703"
#define AppSecret @"ec32f358efeb446289d551b0dbd2d0a7"


@implementation HelpNetWorking



+ (NSURLSessionDataTask *)getCarDataWithBlock:(void (^)(NSObject *car, NSError *error))block {
    
    NSDictionary *parameters = @{@"appkey": APPKEY, @"category":@"美食", @"city":@"上海", @"latitude":@"31.18268013000488", @"longitude":@"121.42769622802734", @"sort":@"sort", @"limit":@"20", @"offset_type":@"1", @"out_offset_type":@"1", @"platform":@"2"};
    
    return [[AFAppDotNetAPIClient sharedClient] GET:@"/v1/business/find_fusinesses" parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSString *string = (NSString *)JSON;
        NSLog(@"%@:  %@", [JSON class], string);
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"Failure !");
        
    }];
}


@end
