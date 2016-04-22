//
//  IcomNSObject.h
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IcomNSObject : NSObject

+ (void)icomchange:(void(^)(NSDictionary *icomdic))success;

+ (void)click:(NSDictionary *)dic Andicomchange:(void(^)(NSDictionary *icomdic))success;

+ (void)wish:(void(^)(NSDictionary *wishdic))success;

+ (void)addwish:(NSDictionary *)addwishdic Andaddwish:(void (^)(NSDictionary *dic))success;

+ (void)userinfo:(void(^)(NSDictionary *info))success;

+ (void)name:(NSDictionary *)dic Andicomchange:(void(^)(NSDictionary *name))success;

+ (void)birthday:(NSDictionary *)dic Andicomchange:(void(^)(NSDictionary *birthday))success;

+ (void)signature:(NSDictionary *)dic Andicomchange:(void(^)(NSDictionary *signature))success;

+ (void)deletewish:(NSDictionary *)dic Andicomchange:(void(^)(NSDictionary *signature))success;

@end
