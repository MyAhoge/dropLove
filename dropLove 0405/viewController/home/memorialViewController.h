//
//  memorialViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memorialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *table;

@property(strong,nonatomic)UIView *myview;

@property(strong,nonatomic)UIImageView *image;

@property(strong,nonatomic)UILabel *weloveLab;

@property(strong,nonatomic)UILabel *lovedateLab;

@property(strong,nonatomic)UILabel *alldateLab;

@property(strong,nonatomic)UILabel *dayLab;

@property(strong,nonatomic)UILabel *firstline;
@end
