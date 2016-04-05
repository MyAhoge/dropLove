//
//  weatherServices.h
//  dropLove
//
//  Created by Mayday_xy on 16/3/29.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherServices : NSObject
- (void)weatherData:(NSString *)cityName addWithSucess:(void(^)(NSDictionary *dic))sucess addWithEror:(void(^)(NSString *str))eroor;

@end
