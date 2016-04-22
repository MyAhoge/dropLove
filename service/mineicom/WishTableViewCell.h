//
//  WishTableViewCell.h
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *contentlab;

@property (strong, nonatomic) UILabel *datelab;

@property (strong, nonatomic) UILabel *placelab;

@property (strong, nonatomic) UIImageView *image;

@property (strong, nonatomic) UIImageView *image2;

@property (strong, nonatomic) UIImageView *image3;

@property (assign, nonatomic) int labheight;

@property (strong, nonatomic)UIButton *deletebtn;

- (void)setHeight:(NSString *)text;

@end
