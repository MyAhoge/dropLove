//
//  dropHeader.h
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#ifndef dropHeader_h
#define dropHeader_h
//头文件
#import "HomeViewController.h"
#import "MineViewController.h"
#import "SocialViewController.h"
#import "TimeAxisViewController.h"
//
#import "PlistLocalInfo.h"
#import "SharkViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "weatherServices.h"
//0330
#import <RongIMKit/RongIMKit.h>
#import "AppDelegate.h"
#import "timelistcell.h"
#import "piclistcell.h"
#import "dataService.h"
//0331
#import "commentViewController.h"
#import "publishViewController.h"
#import "commentcell.h"
//0405
#import "memorialViewController.h"
#import "memorialTableViewCell.h"
#import "socialCell.h"
#import "socialPublishController.h"
//0406
#import "editMemorialDayViewController.h"
#import "addMemorialDayViewController.h"

//***********************************//
//0406
#import "timeaxisModel.h"
#import "socialModel.h"
#import "socialcommentViewController.h"
#import "socialCommentCell.h"

// 0407
#import "WishViewController.h"
#import "IcomNSObject.h"
#import "WishTableViewCell.h"
//0407
#import "memorialDayModel.h"
#import "ShareViewController.h"
//0409
#import "ImageViewController.h"
#import "BIDContentCell.h"
//0410
#import "timeListimagecell.h"
//0411
#import "socialImgCell.h"

//0408
#import "WakeViewController.h"
#import "ClockViewController.h"
#import "ClockModel.h"

//0412
#import "loginViewController.h"
#import "registerViewController.h"

#import "PSInfoTableViewCell.h"
#import "ClockModel.h"
#import "SetViewController.h"
#import "PSInfoViewController.h"
//0413
#import "forgetViewController.h"
#import "marryViewController.h"

//0413
#import "NumSetViewController.h"
#import "NumSafetyViewController.h"
#import "ScreenPasswordViewController.h"

//0414
#import <SMS_SDK/SMSSDK.h>
#import "reTwoViewController.h"
#import "forTwoViewController.h"

// 0414
#import "NoticeTableViewCell.h"
#import "NoticeViewController.h"
#import "OpinionViewController.h"
#import "TouchIDViewController.h"

//0415
#import "requestViewController.h"
#import "invitationViewController.h"


#pragma mark 常用宏
//***********************************//
#define WIDTH self.view.frame.size.width

#define HEIGHT self.view.frame.size.height

#define WIDTH_MY [UIScreen mainScreen].bounds.size.width

#define HEIGHT_MY [UIScreen mainScreen].bounds.size.height

#define COLOR(r, g, b,x) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:x]

#define FONT(x) [UIFont systemFontOfSize:x]

#define COLOR_MINE [UIColor colorWithRed:235.0/255.0 green:80.0/255.0 blue:70.0/255.0 alpha:1]

#define WEATHER_KEY @"9908da26ae6daf5115423beccd4a1b73"

#define WEATHER_URL @"http://op.juhe.cn/onebox/weather/query"

//0330
//荣云
#define RONGYUN_KEY @"e5t4ouvptd73a"
#define TOKEN @"FRKLiEKf8ni4+me2R37Q55e+9qvH6fp6vNYL7dFl8kGJmQkqmrIilIiVdFmckTgRX79ocALvDncwOZjzsN0ejA=="
#define MICOLOR [UIColor colorWithRed:243.0/255.0 green:239.0/255.0 blue:230.0/255.0 alpha:1]
//登录按钮颜色
#define COLOR_LOGINBTN [UIColor colorWithRed:55/255.0 green:205/255.0 blue:50/255.0 alpha:1]

//0414
//短信验证码
#define APPKEY    @"11a6b2e6af542"
#define APPSECRET @"1b92eca49c155223ba9df4eefc5b754e"
//返回按钮frame
#define BACK_FRAME [[UIButton alloc]initWithFrame:CGRectMake(10, 32.5, 10, 20)]


//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
//});

#endif /* dropHeader_h */
