//
//  socialcommentViewController.h
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialcommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) UITableView *table;

@property (copy, nonatomic) NSString *headerImgStr;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *date;

@property (copy, nonatomic) NSString *time;

@property (copy, nonatomic) NSString *content;

@property (assign, nonatomic) int height;

@property (assign, nonatomic) int cellHeight;


@property (strong, nonatomic) UIImageView *headerImg;

@property (strong, nonatomic) UILabel *nameLab;

@property (strong, nonatomic) UILabel *contentLab;

@property (strong, nonatomic) UILabel *timeLab;

@property (strong, nonatomic) UIButton *commentBtn;

@property (strong, nonatomic) UIView *footView;

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) NSMutableArray *commentMutArr;

@property (strong, nonatomic) NSArray *imgArr;

@end
