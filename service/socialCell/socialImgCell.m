//
//  socialImgCell.m
//  dropLove
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialImgCell.h"

#import "dropHeader.h"

@implementation socialImgCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellView = [[UIView alloc]init];
        [self.contentView addSubview:_cellView];
        self.cellView.backgroundColor = MICOLOR;
        
        self.headerImg = [[UIImageView alloc]init];
        [self.cellView addSubview:_headerImg];
        
        self.headerLab = [[UILabel alloc]init];
        [self.cellView addSubview:_headerLab];
        self.headerLab.font = FONT(13);
        
        self.contentLab = [[UILabel alloc]init];
        [self.cellView addSubview:_contentLab];
        self.contentLab.font = FONT(13);
        self.contentLab.numberOfLines = 0;
        
        
        self.timeLab = [[UILabel alloc]init];
        [self.cellView addSubview:_timeLab];
        self.timeLab.font = FONT(13);
        
        self.commentBtn = [[UIButton alloc]init];
        [self.cellView addSubview:_commentBtn];
        
        self.image1 = [[UIImageView alloc]init];
        [self.cellView addSubview:_image1];
        
        self.image2 = [[UIImageView alloc]init];
        [self.cellView addSubview:_image2];
        
        self.image3 = [[UIImageView alloc]init];
        [self.cellView addSubview:_image3];
        
        
        self.deleteBtn = [[UIButton alloc]init];
        [self.cellView addSubview:_deleteBtn];
        self.deleteBtn.titleLabel.font = FONT(13);
        
    }
    return self;
}
- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(WIDTH_MY-20, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.labHeight = textSize.size.height;
    
    frame.size.height = _labHeight + 110 + (WIDTH_MY-80)/3;
    self.frame = frame;
}
/**
 *  <#Description#>
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellView.frame   = CGRectMake(0, 5, WIDTH_MY, self.frame.size.height-10);
    
    self.headerImg.frame  = CGRectMake(10, 10, 50, 50);
    
    self.headerLab.frame  = CGRectMake(_headerImg.frame.size.width+_headerImg.frame.origin.x+10, _headerImg.frame.origin.y, 100, 20);
    
    self.timeLab.frame    = CGRectMake(_headerLab.frame.origin.x, _headerLab.frame.size.height+_headerLab.frame.origin.y+5, 80, 20);
    
    self.contentLab.frame = CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height +10, WIDTH_MY- 20, _labHeight);
    
    
    self.image1.frame       = CGRectMake(_contentLab.frame.origin.x, _contentLab.frame.size.height+_contentLab.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);
    
    self.image2.frame       = CGRectMake(_contentLab.frame.origin.x +10+ (WIDTH_MY-80)/3, _contentLab.frame.size.height+_contentLab.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);
    
    self.image3.frame       = CGRectMake(_contentLab.frame.origin.x +10+ 2*(WIDTH_MY-80)/3, _contentLab.frame.size.height+_contentLab.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);
    
    self.commentBtn.frame = CGRectMake(WIDTH_MY-10-25, _image1.frame.origin.y+_image1.frame.size.height+5, 25, 20);
    
    self.deleteBtn.frame = CGRectMake(WIDTH_MY-10-20, _headerLab.frame.origin.y, 20, 20);
}


@end
