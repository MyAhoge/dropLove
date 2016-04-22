//
//  NoticeTableViewCell.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel *lab;

@property (assign, nonatomic) int labheight;

- (void)setHeight:(NSString *)text;

@end
