//
//  commentcell.h
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentcell : UITableViewCell

- (float)setHeight:(NSString *)text;

@property (strong, nonatomic) UIView  *myView;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *headerImg;

@property (strong, nonatomic) UILabel *timeLab;



@property (assign, nonatomic) int a;


@end
