//
//  socialCommentCell.h
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialCommentCell : UITableViewCell

@property (strong, nonatomic) UIView  *view1;

@property (strong, nonatomic) UIImageView *headerImg;

@property (strong, nonatomic) UILabel *nameLab;

@property (strong, nonatomic) UILabel *contentLab;

@property (strong, nonatomic) UILabel *timeLab;

@property (assign, nonatomic) int labHeight;

- (float)setHeight:(NSString *)text;

@end
