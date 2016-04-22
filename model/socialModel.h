//
//  socialModel.h
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface socialModel : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *headerImg;

@property (copy, nonatomic) NSString *content;

@property (copy, nonatomic) NSString *time;

@property (copy, nonatomic) NSString *date;

@property (copy, nonatomic) NSString *userid;

@property (copy, nonatomic) NSString *socialId;

@property (strong, nonatomic) NSArray *imgArr;

@end
