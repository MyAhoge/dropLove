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
   
        self.dateView = [[UIView alloc]init];
        
        self.dateView.backgroundColor = COLOR(46, 204, 255, 1);
        
        [self.contentView addSubview:self.dateView];
        
        self.yearLab = [[UILabel alloc]init];
        
        self.yearLab.textColor = [UIColor whiteColor];
        
        self.yearLab.font = FONT(12);
        
        [self.contentView addSubview:self.yearLab];
        
        self.dayLab = [[UILabel alloc]init];
        
        self.dayLab.textColor = [UIColor whiteColor];
        
        self.dayLab.font = FONT(16);
        
        [self.contentView addSubview:self.dayLab];
        
        self.detailLab = [[UILabel alloc]init];
        
        self.detailLab.font = FONT(15);
        
        self.detailLab.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.detailLab];
        
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

    
    self.dateView.frame = CGRectMake(0, 0, 55, 50);
    

    self.yearLab.frame = CGRectMake(0, 33, 55, 15);
    
    self.dayLab.frame = CGRectMake(16, 5, 25, 25);
    
    self.detailLab.frame = CGRectMake(60, 15, WIDTH_MY-60-85, 21);
    
    self.tianLab.frame = CGRectMake(WIDTH_MY-41, 15, 31, 21);
    
    self.numLab.frame = CGRectMake(WIDTH_MY-85, 15, 60, 23);
    
}

@end
