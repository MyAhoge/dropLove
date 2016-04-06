//
//  socialCell.m
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialCell.h"
#import "dropHeader.h"

@implementation socialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellView = [[UIView alloc]init];
        [self.contentView addSubview:_cellView];
        
        self.headerImg = [[UIImageView alloc]init];
        [self.cellView addSubview:_headerImg];
        
        self.headerLab = [[UILabel alloc]init];
        [self.cellView addSubview:_headerLab];
        self.headerLab.font = FONT(13);
        
        self.contentLab = [[UILabel alloc]init];
        [self.cellView addSubview:_contentLab];
        self.contentLab.font = FONT(13);
        self.contentLab.numberOfLines = 2;
        
        
        self.timeLab = [[UILabel alloc]init];
        [self.cellView addSubview:_timeLab];
        self.timeLab.font = FONT(13);
        
        self.commentBtn = [[UIButton alloc]init];
        [self.cellView addSubview:_commentBtn];
        
    }
    return self;
}

- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.labHeight = textSize.size.height;
    
    frame.size.height = _labHeight + 100;
    self.frame = frame;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cellView.frame   = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);

    self.headerImg.frame  = CGRectMake(10, 10, 50, 50);

    self.headerLab.frame  = CGRectMake(_headerImg.frame.size.width+_headerImg.frame.origin.x+10, _headerImg.frame.origin.y, 100, 20);

    self.timeLab.frame    = CGRectMake(_headerLab.frame.origin.x, _headerLab.frame.size.height+_headerLab.frame.origin.y+5, 80, 20);

    self.contentLab.frame = CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height +10, WIDTH_MY- 20, _labHeight);

    self.commentBtn.frame = CGRectMake(WIDTH_MY-10-25, _contentLab.frame.origin.y+_contentLab.frame.size.height+10, 25, 20);
}

@end
