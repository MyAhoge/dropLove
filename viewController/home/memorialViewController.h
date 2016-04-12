//
//  memorialViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addMemdayDelegate<NSObject>

-(void)showMemorial:(NSDictionary *)addDic;


@end

@protocol editMemdatDelegate <NSObject>

-(void)printDate:(NSString *)loveDateString;

@end

@interface memorialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,addMemdayDelegate,editMemdatDelegate>

@property(strong,nonatomic)UITableView *table;

@property(strong,nonatomic)UIView *myview;

@property(strong,nonatomic)UIImageView *image;

@property(strong,nonatomic)UILabel *weloveLab;

@property(strong,nonatomic)UILabel *lovedateLab;

@property(strong,nonatomic)UILabel *alldateLab;

@property(strong,nonatomic)UILabel *dayLab;

@property(strong,nonatomic)UILabel *firstline;

@property(strong,nonatomic)UITapGestureRecognizer *tapGesturRecognizer;

@property(strong,nonatomic)NSMutableArray *Arr;

@property(strong,nonatomic)NSDictionary *dic;

@property(strong,nonatomic)NSMutableArray *cellArr;

@property(copy,nonatomic)NSString  *loveStr;

@end
