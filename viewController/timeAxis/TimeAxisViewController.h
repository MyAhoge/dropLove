//
//  TimeAxisViewController.h
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendDicDelegate <NSObject>

-(void)sendMethod:(NSDictionary *)send;

@end

@interface TimeAxisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,sendDicDelegate>

@property (strong, nonatomic) UIScrollView *scroll;

@property (strong, nonatomic) UIView *timeView;

@property (strong, nonatomic) UIView *picView;

@property (strong, nonatomic) UIView *headerView;


@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) UITableView *picTable;


@property (strong, nonatomic) NSMutableArray *contentArr;

@property (strong, nonatomic) NSMutableArray *timeArr;

//@property (strong, nonatomic) NSMutableArray *titleArr;

@property (strong, nonatomic) NSMutableArray *dateArr;


@property (strong, nonatomic) NSDictionary  *dic;

@property (strong, nonatomic) NSDictionary *sendDic;


@property (assign, nonatomic) int height;


@property (strong, nonatomic) NSMutableArray *sourceArr;

@end
