//
//  dataService.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "dataService.h"
#import "dropHeader.h"


/**
 *  数据处理
 */
@implementation dataService

+ (void)timeAxisAddWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 时光轴添加数据
+ (void)addDataDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/timeaxis/timeaxisadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 社区数据请求
+ (void)socialAddWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/social/social" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
