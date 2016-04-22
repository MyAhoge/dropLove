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
    [manager POST:@"http://10.110.5.16:8888/drapLove/index.php/home/draplove/type" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}




+ (void)click:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *icomdic))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://10.110.5.16:8888/drapLove/index.php/home/draplove/edim" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
}


//  读取愿望
+ (void)wish:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.16:8888/drapLove/index.php/home/wish/wish" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"读取愿望成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"读取愿望失败");
    }];

    
}


+ (void)addwish:(NSDictionary *)addwishdic Andaddwish:(void (^)(NSDictionary *dic))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *dic1 = addwishdic;
    
    [manager POST:@"http://10.110.5.16:8888/drapLove/index.php/home/wish/addwish" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
         NSLog(@"添加愿望成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"添加愿望失败");
    }];
    
    NSLog(@"+++++输出添加内容%@",addwishdic);
    
}


@end
