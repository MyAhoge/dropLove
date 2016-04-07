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
//#import "TimeCommentViewController.h"
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

#define RONGYUN_KEY @"e5t4ouvptd73a"

#define TOKEN @"FRKLiEKf8ni4+me2R37Q55e+9qvH6fp6vNYL7dFl8kGJmQkqmrIilIiVdFmckTgRX79ocALvDncwOZjzsN0ejA=="

#define URL @"http://10.110.5.58:8888/mylove/index.php/home/timeaxis/timeaxis"

#define MICOLOR [UIColor colorWithRed:243.0/255.0 green:239.0/255.0 blue:230.0/255.0 alpha:1]

//***********************************//
//0406
#import "timeaxisModel.h"
#import "socialModel.h"
#import "socialcommentViewController.h"
#import "socialCommentCell.h"




#endif /* dropHeader_h */
