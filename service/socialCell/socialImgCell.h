//
//  socialImgCell.h
//  dropLove
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialImgCell : UITableViewCell
/**
 *  <#Description#>
 */
@property (strong, nonatomic) UIView *cellView;

@property (strong, nonatomic) UIImageView *headerImg;

@property (strong, nonatomic) UILabel *headerLab;

@property (strong, nonatomic) UILabel *timeLab;

@property (strong, nonatomic) UILabel *contentLab;

@property (strong, nonatomic) UIButton *commentBtn;

@property (strong, nonatomic) UIButton *deleteBtn;

@property (assign, nonatomic) int labHeight;

@property (strong, nonatomic) UIImageView *image1;

@property (strong, nonatomic) UIImageView *image2;

@property (strong, nonatomic) UIImageView *image3;

- (void)setHeight:(NSString *)text;

@end
