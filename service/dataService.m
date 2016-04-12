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

#pragma mark uierId
+ (NSString *)myUserId{
    
    return @"1";
}
#pragma mark 时光轴请求数据
+ (void)timeAxisDic:(NSDictionary *)dic AndWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:URL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
//上传图片
+ (void)timeaxisSetImg:(NSArray *)imgs andHomeWorkId:(int)homeWorkId andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSNumber *timeid = [NSNumber numberWithInt:homeWorkId];
    NSDictionary *dic = @{
                          @"timeid":timeid
                          };
    int i = 0;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    for (UIImage *img in imgs) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateStr,i];
        
        [manage POST:@"http://10.110.5.58:8888/mylove/index.php/home/timeaxis/timeaxisaddimg" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *imageData;
            imageData = UIImageJPEGRepresentation(img, 1.0f);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%d",homeWorkId] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@">>>%@",responseObject);
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        i++;
    }
}
#pragma mark  时光轴删除数据
+ (void)timeaxisDelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/timeaxis/timeaxisdelete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**********************社区*********************/
#pragma mark 社区数据请求
+ (void)socialDic:(NSDictionary *)dic AndWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/social/social" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 社区数据添加
+ (void)socialAddDataDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/social/socialadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark  社区删除数据
+ (void)socialdelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/social/deletesocial" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 纪念日数据请求
+(void)memorialDayDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/Home/MemorialDay" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+(void)mmmm:(NSDictionary *)dic addWith:(void (^)(NSDictionary *dic))sucess {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/Home/MemorialDay" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 纪念日添加

+(void)memorialDataAddDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/home/memorialdayadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error!!!");

    }];
    
}

#pragma mark  纪念日删除数据
+ (void)memorialDatadelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://10.110.5.58:8888/mylove/index.php/home/home/memorialdaydelete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
