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
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    return @"1";
}
//   2147483647
#pragma mark 登录
+ (void)loginDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/login" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录失败");
    }];
}
#pragma mark 注册
+ (void)registDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/register" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"注册失败");
    }];
}
#pragma mark 重置密码
+ (void)changePasswordDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/changepassword" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"重置密码失败");
    }];
}
#pragma mark 获取号码
+ (void)getNumberDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))errro{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/getnumber" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取号码失败");
    }];
}
#pragma mark 匹配刷新
+ (void)requestDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))errro{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/request" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"匹配失败");
    }];
}
#pragma mark 匹配提交
+ (void)invitationDic:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))errro{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/home/invitation" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"匹配失败");
    }];
}
#pragma mark 上传头像
+ (void)uploadHeaderImg:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithFaile:(void (^)(NSDictionary *))errro{
    NSString *url = @"http://115.159.215.216/mylove/index.php/home/Mine/uploadimg";
    UIImage *headerimage = [dic objectForKey:@"imgarr"][0];
    NSDictionary *idDic = @{@"userid":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:idDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        NSData *imageData = UIImagePNGRepresentation(headerimage);
        
        [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

//TODO: / 时光轴 /
#pragma mark 时光轴请求数据
+ (void)timeAxisDic:(NSDictionary *)dic AndWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Timeaxis/timeaxis" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"时光轴请求数据失败");
    }];

}

#pragma mark 时光轴添加数据
+ (void)addDataDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Timeaxis/timeaxisadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"时光轴添加数据失败");
    }];
}
//上传图片
+ (void)timeaxisSetImg:(NSArray *)imgs andTimeId:(NSString *)timeId andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{
    
    NSDictionary *dic = @{
                          @"timeid":timeId
                          };
    int i = 0;
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];

    for (UIImage *img in imgs) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateStr,i];
        
        [manage POST:@"http://115.159.215.216/mylove/index.php/home/Timeaxis/uploadimgs" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *imageData = UIImageJPEGRepresentation(img, 1.0f);
            [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"jpg/png/jpeg"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@">>>%@",responseObject);
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败");
            NSLog(@"%@", error);
        }];
        i++;
    }
}
#pragma mark  时光轴删除数据
+ (void)timeaxisDelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Timeaxis/timeaxisdelete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"时光轴删除数据失败");
    }];
}
//TODO: /  社区  /
#pragma mark 社区数据请求
+ (void)socialDic:(NSDictionary *)dic AndWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216:80/myLove/index.php/Home/social/social" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"社区数据请求失败");
    }];
}
#pragma mark 社区评论请求
+ (void)socialCommentData:(NSDictionary *)dic andWidthSucess:(void (^)(NSDictionary *))sucess addWidthFiel:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
        [manager POST:@"http://115.159.215.216:80/myLove/index.php/Home/social/comment" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            sucess(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"社区数据请求失败");
        }];
    
    
}

//+ (void)socialImg:(NSDictionary *)dic andWidth:(void (^)(NSDictionary *))sucess addWidth:(void (^)(NSDictionary *))error{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [manager POST:@"http://115.159.215.216:80/myLove/index.php/Home/social/social" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        sucess(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"社区数据请求失败");
//    }];
//}

#pragma mark 社区数据添加
+ (void)socialAddDataDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216:80/myLove/index.php/Home/Social/socialadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"社区添加数据失败");
    }];
}
//上传图片
+ (void)socialSetImg:(NSArray *)imgs andSocialId:(NSString *)socialId andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{
    
    NSDictionary *dic = @{
                          @"socialid":socialId
                          };
    int i = 0;
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    for (UIImage *img in imgs) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateStr,i];
        
        [manage POST:@"http://115.159.215.216/mylove/index.php/home/Social/uploadimgs" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSData *imageData = UIImageJPEGRepresentation(img, 1.0f);
            [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"jpg/png/jpeg"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@">>>%@",responseObject);
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传图片失败");
            NSLog(@"%@", error);
        }];
        i++;
    }
}
#pragma mark  社区删除数据
+ (void)socialdelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216:80/myLove/index.php/Home/Social/socialdelete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
         NSLog(@"社区删除数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"社区删除数据失败");
    }];
}
//TODO: /  纪念日  /
#pragma mark 纪念日数据请求
+(void)memorialDayDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/home/Home/memorialday" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
         NSLog(@"纪念日请求数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"纪念日请求数据失败");
    }];
}

+(void)mmmm:(NSDictionary *)dic addWith:(void (^)(NSDictionary *dic))sucess {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/mylove/index.php/Home/Home/memorialday" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 纪念日添加

+(void)memorialDataAddDic:(NSDictionary *)dic addWith:(void (^)(NSDictionary *))sucess addWith:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://115.159.215.216/myLove/index.php/Home/Home/memorialdayadd" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
        NSLog(@"纪念日添加数据成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"纪念日添加数据失败");
    }];
}

#pragma mark  纪念日删除数据
+ (void)memorialDatadelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *))sucess andWithError:(void (^)(NSDictionary *))error{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://115.159.215.216/myLove/index.php/Home/Home/memorialdaydelete" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"纪念日删除数据失败"); 
    }];
}


@end
