//
//  PSInfoTableViewCell.m
//  dropLove
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "PSInfoTableViewCell.h"
#import "dropHeader.h"

@implementation PSInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.namelab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 60, 20)];
        self.namelab.font = FONT(15);
        self.namelab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_namelab];
        
        self.textname = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, WIDTH_MY-80-15-10-10, 20)];
        self.textname.font = FONT(15);
        self.textname.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_textname
         ];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

@end
