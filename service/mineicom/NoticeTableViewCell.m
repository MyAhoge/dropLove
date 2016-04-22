//
//  NoticeTableViewCell.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "dropHeader.h"

@implementation NoticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.lab = [[UILabel alloc]init];
        self.lab.numberOfLines = 0;
        
        self.lab.font = FONT(13);
        
        [self.contentView addSubview:self.lab];
    }
    return self;
}
- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.labheight = textSize.size.height;
    
//    frame.size.height = _labheight + (WIDTH_MY-20-6)/3+20+20;
    frame.size.height = _labheight +10;
    self.frame = frame;
}

-(void)layoutSubviews{
    self.lab.frame  = CGRectMake(5, 5, WIDTH_MY, _labheight);
}
@end
