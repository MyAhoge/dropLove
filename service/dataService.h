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



//TODO:userid
+ (NSString *)myUserId;

//TODO: 登录
+ (void)loginDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))error;
//TODO: 注册
+ (void)registDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))error;
//TODO: 获取号码
+ (void)getNumberDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))errro;
//TODO: 匹配刷新
+ (void)requestDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))errro;
//TODO: 匹配提交
+ (void)invitationDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))errro;
//TODO: 上传头像
+ (void)uploadHeaderImg:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))errro;;
//TODO: 重置密码
+ (void)changePasswordDic:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithFaile:(void(^)(NSDictionary *faile))error;


/************时光轴************/
//TODO: 时光轴添加数据
+ (void)addDataDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+ (void)timeaxisSetImg:(NSArray *)imgs andTimeId:(NSString *)timeId andSuccess:(void (^)(NSString *str))success andFail:(void (^)(NSString *error))fail;

+ (void)timeAxisDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;
//TODO:时光轴删除
+ (void)timeaxisDelete:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithError:(void(^)(NSDictionary *error))error;

/************社区************/
//TODO:社区
+ (void)socialDic:(NSDictionary *)dic AndWidth:(void(^)(NSDictionary *resultDic))sucess addWidth:(void(^)(NSDictionary *error))error;

//TODO:社区删除
+ (void)socialdelete:(NSDictionary *)dic andWithSucess:(void(^)(NSDictionary *resultDic))sucess andWithError:(void(^)(NSDictionary *error))error;

+ (void)socialAddDataDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+ (void)socialSetImg:(NSArray *)imgs andSocialId:(NSString *)socialId andSuccess:(void (^)(NSString *result))success andFail:(void (^)(NSString *result))fail;

//TODO:纪念日
+ (void)memorialDayDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+(void)mmmm:(NSDictionary *)dic addWith:(void (^)(NSDictionary *dic))sucess;

+ (void)memorialDataAddDic:(NSDictionary *)dic addWith:(void(^)(NSDictionary *resultDic))sucess addWith:(void(^)(NSDictionary *errorDic))error;

+ (void)memorialDatadelete:(NSDictionary *)dic andWithSucess:(void (^)(NSDictionary *result))sucess andWithError:(void (^)(NSDictionary *errorDic))error;

@end
