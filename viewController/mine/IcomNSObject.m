//
//  IcomNSObject.m
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "IcomNSObject.h"
#import "AFNetworking.h"

@implementation IcomNSObject

+ (void)icomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://localhost:8888/drapLove/index.php/home/draplove/type" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}




+ (void)click:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [manager POST:@"http://localhost:8888/drapLove/index.php/home/draplove/edim" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
    
    
}


@end
