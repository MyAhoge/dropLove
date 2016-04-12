//
//  timelistcell.h
//  dropLove
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timelistcell : UITableViewCell

- (void)setHeight:(NSString *)text;

@property (strong, nonatomic) UIView  *myView;

@property (strong, nonatomic) UILabel *dateLabel1;

@property (strong, nonatomic) UILabel *dateLabel2;

@property (strong, nonatomic) UILabel *lineLabel;

@property (strong, nonatomic) UIImageView *heartImage;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *contentlabel;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIButton *deletebtn;

@property (strong, nonatomic) UIButton *btn;

@property (assign, nonatomic) CGFloat a;

@end
