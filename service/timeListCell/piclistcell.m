//
//  piclistcell.m
//  dropLove
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "piclistcell.h"
#import "dropHeader.h"


@implementation piclistcell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myView = [[UIView alloc]init];
        [self.contentView addSubview:_myView];
        
        self.dateLabel1 = [[UILabel alloc]init];
        [self.myView addSubview:_dateLabel1];
        
        self.dateLabel2 = [[UILabel alloc]init];
        [self.myView addSubview:_dateLabel2];
        
        self.lineLabel = [[UILabel alloc]init];
        [self.myView addSubview:_lineLabel];
        self.lineLabel.backgroundColor = COLOR(167, 167, 172, 1);
        
        self.image1 = [[UIImageView alloc]init];
        [self.myView addSubview:_image1];
        
        self.image2 = [[UIImageView alloc]init];
        [self.myView addSubview:_image2];
        
        self.image3 = [[UIImageView alloc]init];
        [self.myView addSubview:_image3];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY-184-49);
    self.dateLabel1.frame = CGRectMake(10, 10, 40, 20);
    self.dateLabel2.frame = CGRectMake(10, _dateLabel1.frame.size.height+_dateLabel1.frame.origin.y, 40, 20);
    self.lineLabel.frame = CGRectMake(59, 0, 2, _myView.frame.size.height);
    self.image1.frame = CGRectMake(70, 10, (WIDTH_MY-70-10)/3-5, 80);
    self.image2.frame = CGRectMake(70+(WIDTH_MY-70-10)/3+5, 10, (WIDTH_MY-70-10)/3-5, 80);
    self.image3.frame = CGRectMake(70+(WIDTH_MY-70-10)/3*2+5, 10, (WIDTH_MY-70-10)/3-5, 80);
    
}
@end
