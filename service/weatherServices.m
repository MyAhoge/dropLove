//
//  weatherServices.m
//  dropLove
//
//  Created by Mayday_xy on 16/3/29.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "weatherServices.h"
#import "dropHeader.h"

@implementation weatherServices

- (void)weatherData:(NSString *)cityName addWithSucess:(void (^)(NSDictionary *dic))sucess addWithEror:(void (^)(NSString *str))eroor{
    
    if (![cityName isEqualToString:@""]) {
        
        NSString *name = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *urlPath = [NSString stringWithFormat:@"%@?cityname=%@&key=%@", WEATHER_URL, name, WEATHER_KEY];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            sucess(dic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        NSLog(@"失败");
    }
    
    
}


@end
