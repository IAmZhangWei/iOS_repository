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
#import "ProvinceResult.h"
#define APPKEY  @"342bf2f8fb179541142f0657c86f8910"
#import "Car.h"
@implementation HelpNetWorking

#pragma mark -

//+ (NSURLSessionDataTask *)getProvinceDataWithBlock:(void (^)(ProvinceResult *provinceResult, NSError *error))block {
//    
////    return [[AFAppDotNetAPIClient sharedClient] POST:<#(NSString *)#> parameters:<#(id)#> success:^(NSURLSessionDataTask *task, id responseObject) {
////        <#code#>
////    } failure:^(NSURLSessionDataTask *task, NSError *error) {
////        <#code#>
////    }];
//    
//    NSDictionary *parameters = @{@"key": APPKEY};
//    
//    return [[AFAppDotNetAPIClient sharedClient] GET:@"wz/citys" parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        
//        NSDictionary *responsObjects = (NSDictionary *)JSON;
//                
//        ProvinceResult *provinceResult = [ProvinceResult provinceResultWithDic:responsObjects];
//        
//        if (block) {
//            //block(mutableArr,nil);
//            block(provinceResult,nil);
//        }
//        //NSLog(@"%@",JSON);
//        
//    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//        if (block) {
//            block([NSArray array], error);
//        }
//    }];
//}
//

+ (NSURLSessionDataTask *)getCarDataWithBlock:(void (^)(Car *car, NSError *error))block {
    
    //    return [[AFAppDotNetAPIClient sharedClient] POST:<#(NSString *)#> parameters:<#(id)#> success:^(NSURLSessionDataTask *task, id responseObject) {
    //        <#code#>
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        <#code#>
    //    }];
    
    NSDictionary *parameters = @{@"key": APPKEY};
    
    return [[AFAppDotNetAPIClient sharedClient] GET:@"wz/hpzl" parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary *responsObjects = (NSDictionary *)JSON;
        
       
        
        if (block) {
            
           // block(provinceResult,nil);
        }
        //NSLog(@"%@",JSON);
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end
