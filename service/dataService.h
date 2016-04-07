//
//  dataService.h
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface dataService : NSObject

/**
 *  数据处理
// */

+ (void)timeAxisDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;

+ (void)socialDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;

/**
 *  时光轴添加数据
 *
 *  @param dic    传入参输
 *  @param sucess 成功返回
 *  @param error  失败返回
 */
+ (void)addDataDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;
+ (NSString *)myUserId;

@end
