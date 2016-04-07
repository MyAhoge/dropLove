//
//  memorialTableViewCell.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "memorialTableViewCell.h"
#import "dropHeader.h"
@implementation memorialTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        
        self.dateView = [[UILabel alloc]init];
        
        self.dateView.backgroundColor = COLOR(46, 204, 255, 1);
        
        [self.contentView addSubview:self.dateView];
        
        self.yearLab = [[UILabel alloc]init];
        
        self.yearLab.textColor = [UIColor whiteColor];
        
        self.yearLab.font = FONT(12);
        
        [self.contentView addSubview:self.yearLab];
//        
//        self.mouthLab = [[UILabel alloc]init];
//        
//        self.mouthLab.textColor = [UIColor whiteColor];
//        
//        self.mouthLab.font = FONT(13);
//        
//        [self.contentView addSubview:self.mouthLab];
        
        self.dayLab = [[UILabel alloc]init];
        
        self.dayLab.textColor = [UIColor whiteColor];
        
        self.dayLab.font = FONT(16);
        
        [self.contentView addSubview:self.dayLab];
        
        
        
        self.detailLab = [[UILabel alloc]init];
        
        self.detailLab.font = FONT(15);
        
        self.detailLab.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.detailLab];
        
        
        //
        self.tianLab = [[UILabel alloc]init];
        
        self.tianLab.font = FONT(15);
        
        self.tianLab.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.tianLab];
        
        self.numLab = [[UILabel alloc]init];
        
        self.numLab.font = FONT(20);
        
        self.numLab.textAlignment =NSTextAlignmentRight;
        
        self.numLab.textColor = COLOR(46, 204, 255, 1);
        
        [self.contentView addSubview:self.numLab];
    }
    return self;
}
- (void)layoutSubviews{

    
    self.dateView.frame = CGRectMake(0, 0, 50, 50);
    
    self.yearLab.frame = CGRectMake(0, 33, 50, 15);
    
//    self.mouthLab.frame = CGRectMake(34, 33, 18, 15);
    
    self.dayLab.frame = CGRectMake(16, 5, 25, 25);
    
    self.detailLab.frame = CGRectMake(60, 15, 160, 21);
    
    self.tianLab.frame = CGRectMake(WIDTH_MY-41, 15, 31, 21);
    
    self.numLab.frame = CGRectMake(WIDTH_MY-85, 15, 40, 23);
    
}

@end
