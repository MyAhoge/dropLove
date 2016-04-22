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

/**
 *  读取个人信息数据
 *
 */
+ (void)icomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/usermessage" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}



/**
 *  修改心情
 *
 */
+ (void)click:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *icomdic))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/alpha" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
}


/**
 *  /读取愿望
 */
+ (void)wish:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *dic = @{@"userid":@1};
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/wish" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"读取愿望成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"读取愿望失败");
    }];
    
}

/**
 *  添加愿望
 *
 */
+ (void)addwish:(NSDictionary *)addwishdic Andaddwish:(void (^)(NSDictionary *dic))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *dic1 = addwishdic;
    
    NSLog(@"++++++%@",dic1);
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/addwish" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"添加愿望成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"添加愿望失败");
    }];
    
    NSLog(@"+++++输出添加内容%@",addwishdic);
    
}


/**
 *  读取个人信息
 */
+ (void)userinfo:(void (^)(NSDictionary *))success{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *dic = @{@"userid":@1};
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/usermessage" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"读取个人成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"读取个人失败");
    }];
    
}


//+ (void)userinfo:(NSDictionary *)addwishdic Andaddwish:(void (^)(NSDictionary *))success{
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//    NSDictionary *dic1 = addwishdic;
//
//    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/usermessage" parameters:dic1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//        NSLog(@"添加个人成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"添加个人失败");
//    }];
//
//    NSLog(@"+++++输出添加内容%@",addwishdic);
//
//}



/**
 *  昵称
 *
 */
+ (void)name:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/name" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
    
    
}

/**
 *  生日
 *
 */
+ (void)birthday:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/brithday" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
}

/**
 *  个性签名
 *
 */
+ (void)signature:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/signature" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
}

/**
 *  删除愿望
 *
 */
+ (void)deletewish:(NSDictionary *)dic Andicomchange:(void (^)(NSDictionary *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Mine/delete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    NSLog(@"%@",dic);
    
    
}


@end
