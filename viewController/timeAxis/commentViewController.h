//
//  commentViewController.h
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

//@property (strong, nonatomic) NSDictionary *sourceDic;

@property (copy, nonatomic) NSString *contentStr;

@property (copy, nonatomic) NSString *timeStr;

@property (copy, nonatomic) NSString *dateStr1;

@property (copy, nonatomic) NSString *dateStr2;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) NSMutableArray *sourceArr;

@property (assign, nonatomic) int headHeight;

@property (strong, nonatomic) UILabel *contentLab;

@property (strong, nonatomic) UILabel *timeLab;

@property (strong, nonatomic) UILabel *dateLab1;

@property (strong, nonatomic) UILabel *dateLab2;

@property (strong, nonatomic) UIView *footView;

@property (strong, nonatomic) UITextView *textView;


@end
