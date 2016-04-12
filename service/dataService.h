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
 */

/**
*  时光轴添加数据
*  @param dic    传入参输
*  @param sucess 成功返回
*  @param error  失败返回
*/
+ (void)addDataDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+ (void)timeaxisSetImg:(NSArray *)imgs andHomeWorkId:(int)homeWorkId andSuccess:(void (^)(NSString *str))success andFail:(void (^)(NSString *error))fail;

+ (void)timeAxisDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;

//TODO:时光轴删除
+ (void)timeaxisDelete:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithError:(void(^)(NSDictionary *error))error;

/************社区************/
//TODO:社区
+ (void)socialDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;

//TODO:社区删除
+ (void)socialdelete:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithError:(void(^)(NSDictionary *error))error;

+ (void)socialAddDataDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

//TODO:userid
+ (NSString *)myUserId;

//TODO:纪念日
+ (void)memorialDayDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+(void)mmmm:(NSDictionary *)dic addWith:(void (^)(NSDictionary *dic))sucess;

@end
