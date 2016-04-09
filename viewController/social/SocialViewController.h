//
//  SocialViewController.h
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol socialDelegate <NSObject>

- (void)socialSendMethod:(NSDictionary *)sender;

@end
@interface SocialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,socialDelegate>

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) NSMutableArray *headerImgArr;

@property (strong, nonatomic) NSMutableArray *nameArr;

@property (strong, nonatomic) NSMutableArray *contentArr;

@property (strong, nonatomic) NSMutableArray *dateArr;

@property (strong, nonatomic) NSMutableArray *timeArr;

@property (strong, nonatomic) NSMutableArray *sourceArr;

@property (assign, nonatomic) int height;

@property (copy, nonatomic) NSString *userId;

@property (strong, nonatomic) NSDictionary *sendDic;

@end
