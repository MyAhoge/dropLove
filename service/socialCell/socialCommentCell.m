//
//  socialCommentCell.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialCommentCell.h"
#import "dropHeader.h"
@implementation socialCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view1 = [[UIView alloc]init];
        [self.contentView addSubview:_view1];
        
        self.headerImg = [[UIImageView alloc]init];
        [self.view1 addSubview:_headerImg];
        
        self.nameLab = [[UILabel alloc]init];
        [self.view1 addSubview:_nameLab];
        self.nameLab.font = FONT(13);
        
        self.contentLab = [[UILabel alloc]init];
        [self.view1 addSubview:_contentLab];
        self.contentLab.font = FONT(13);
        self.contentLab.numberOfLines = 2;
        
        
        self.timeLab = [[UILabel alloc]init];
        [self.view1 addSubview:_timeLab];
        self.timeLab.font = FONT(13);
        
    }
    return self;
}

- (float)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.labHeight = textSize.size.height;
    
    frame.size.height = _labHeight + 100;
    self.frame = frame;
    return _labHeight;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.view1.frame   = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
    
    self.headerImg.frame  = CGRectMake(10, 10, 50, 50);
    
    self.nameLab.frame  = CGRectMake(_headerImg.frame.size.width+_headerImg.frame.origin.x+10, _headerImg.frame.origin.y, 100, 20);
    
    self.timeLab.frame    = CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.size.height+_nameLab.frame.origin.y+5, 80, 20);
    
    self.contentLab.frame = CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height +10, WIDTH_MY- 20, _labHeight);
    

}

@end
