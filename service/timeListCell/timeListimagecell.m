//
//  timeListimagecell.m
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "timeListimagecell.h"
#import "dropHeader.h"

@implementation timeListimagecell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.contentView addSubview:_myView];
        
        self.dateLabel1 = [[UILabel alloc]init];
        [self.myView addSubview:_dateLabel1];
        
        self.dateLabel2 = [[UILabel alloc]init];
        [self.myView addSubview:_dateLabel2];
        self.dateLabel2.font = FONT(10);
        
        self.lineLabel = [[UILabel alloc]init];
        [self.myView addSubview:_lineLabel];
        self.lineLabel.backgroundColor = COLOR(167, 167, 172, 1);
        
        self.heartImage = [[UIImageView alloc]init];
        [self.myView addSubview:_heartImage];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.myView addSubview:_titleLabel];
        
        self.contentlabel = [[UILabel alloc]init];
        [self.myView addSubview:_contentlabel];
        [self.contentlabel setNumberOfLines:0];
        //        self.contentlabel.textAlignment = NSTextAlignmentLeft;
        self.contentlabel.lineBreakMode = 0;
        self.contentlabel.font = FONT(13);
        [self.contentlabel sizeToFit];
        
        self.timeLabel = [[UILabel alloc]init];
        [self.myView addSubview:_timeLabel];
        self.timeLabel.font = FONT(13);
        
        self.deletebtn = [[UIButton alloc]init];
        [self.myView addSubview:_deletebtn];
        self.deletebtn.titleLabel.font = FONT(13);
        
        self.btn = [[UIButton alloc]init];
        [self.myView addSubview:_btn];
        
        self.image1 = [[UIImageView alloc]init];
        [self.myView addSubview:_image1];
        
        self.image2 = [[UIImageView alloc]init];
        [self.myView addSubview:_image2];
        
        self.image3 = [[UIImageView alloc]init];
        [self.myView addSubview:_image3];
        
        
    }
    return self;
}
- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.a = textSize.size.height;
    
    frame.size.height = _a + 60 + (WIDTH_MY-80)/3;
    self.frame = frame;
}
#pragma mark 计算高度
- (void)layoutSubviews{
    [super layoutSubviews];

    self.myView.frame       = CGRectMake(0, 0, WIDTH_MY, self.frame.size.height);

    self.dateLabel1.frame   = CGRectMake(10, 10, 40, 20);

    self.dateLabel2.frame   = CGRectMake(10, _dateLabel1.frame.size.height+_dateLabel1.frame.origin.y, 50, 20);

    self.lineLabel.frame    = CGRectMake(60, 0, 2, _myView.frame.size.height);

    self.heartImage.frame   = CGRectMake(55, 15, 10, 10);

    self.contentlabel.frame = CGRectMake(70, 10, WIDTH_MY-70-10, _a);

   
    self.image1.frame       = CGRectMake(_contentlabel.frame.origin.x, _a+_contentlabel.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);

    self.image2.frame       = CGRectMake(_contentlabel.frame.origin.x +10+ (WIDTH_MY-100)/3, _a+_contentlabel.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);

    self.image3.frame       = CGRectMake(_contentlabel.frame.origin.x +10+ 2*(WIDTH_MY-80)/3, _a+_contentlabel.frame.origin.y, (WIDTH_MY-100)/3, (WIDTH_MY-100)/3);
    
    self.timeLabel.frame    = CGRectMake(_contentlabel.frame.origin.x, _image1.frame.origin.y+_image1.frame.size.height, 80, 20);
    
    self.deletebtn.frame    = CGRectMake(WIDTH_MY-35-20, _timeLabel.frame.origin.y, 20, 20);
    
    self.btn.frame          = CGRectMake(WIDTH_MY-10-25, _timeLabel.frame.origin.y, 25, 20);

}


@end
