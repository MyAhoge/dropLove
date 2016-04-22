//
//  WishTableViewCell.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WishTableViewCell.h"
#import "dropHeader.h"

@implementation WishTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentlab = [[UILabel alloc] init];
        
        //设置字体颜色为白色
        self.contentlab.textColor = [UIColor blackColor];
        //文字居中显示
        self.contentlab.textAlignment = NSTextAlignmentLeft;
        //自动折行设置
        self.contentlab.numberOfLines = 0;
        self.contentlab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.contentlab];
        
        
        //设置添加愿望时间lable
        self.datelab = [[UILabel alloc]init];
        self.datelab.textAlignment = NSTextAlignmentLeft;
        self.datelab.font = FONT(13);
        self.datelab.textColor = [UIColor grayColor];
        self.datelab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.datelab];
        
        
        //   设置地点lable
        self.placelab = [[UILabel alloc]init];
        self.placelab.textAlignment = NSTextAlignmentRight;
        self.placelab.font = FONT(13);
        self.placelab.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.placelab];
        
        self.deletebtn = [[UIButton alloc]init];
        [self.deletebtn setImage:[UIImage imageNamed:@"delete10.png"] forState: UIControlStateNormal];
        [self.contentView addSubview:_deletebtn];
        
        
        self.image = [[UIImageView alloc]init];
        self.image.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.image];
        
        self.image2 = [[UIImageView alloc]init];
        self.image2.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.image2];
        
        self.image3 = [[UIImageView alloc]init];
        self.image3.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.image3];
        
    }
    
    return self;
}



- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.labheight = textSize.size.height;
    
    frame.size.height = _labheight + (WIDTH_MY-20-6)/3+20+20;
    self.frame = frame;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentlab.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, _labheight);
    self.datelab.frame = CGRectMake(10, _labheight+15+(WIDTH_MY-20-6)/3, 150, 20);
    
    self.placelab.frame = CGRectMake(WIDTH_MY-130, _labheight+15+(WIDTH_MY-20-6)/3, 100, 20);
    
    self.deletebtn.frame = CGRectMake(WIDTH_MY-25, _labheight+15+(WIDTH_MY-20-6)/3+3, 15, 15);
    
    self.image.frame = CGRectMake(10, _labheight+15, (WIDTH_MY-20-6)/3, (WIDTH_MY-20-6)/3);
    
    self.image2.frame = CGRectMake(10+(WIDTH_MY-20-6)/3+3, _labheight+15, (WIDTH_MY-20-6)/3, (WIDTH_MY-20-6)/3);
    
    self.image3.frame = CGRectMake(10+(WIDTH_MY-20-6)/3*2+6, _labheight+15, (WIDTH_MY-20-6)/3, (WIDTH_MY-20-6)/3);
    
}




@end
