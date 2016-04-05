//
//  commentcell.m
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "commentcell.h"
#import "dropHeader.h"
@implementation commentcell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.contentView addSubview:_myView];
        
        self.contentLabel = [[UILabel alloc]init];
        [self.myView addSubview:_contentLabel];
        [self.contentLabel setNumberOfLines:0];
        self.contentLabel.font = FONT(15);    
    }

    return self;
}

- (void)setHeight:(NSString *)text{
    CGRect frame = [self frame];
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(300, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    self.a = textSize.size.height;
    
    frame.size.height = _a + 10;
    self.frame = frame;
}
- (void)layoutSubviews{
    
    self.myView.frame = CGRectMake(0, 0, WIDTH_MY, _height);
    self.contentLabel.frame = CGRectMake(10, 10, WIDTH_MY-20, _a);
    
}
@end
