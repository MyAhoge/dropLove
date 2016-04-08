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

@end
