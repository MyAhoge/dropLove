//
//  NoticeViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic)UITableView *table;
@property (assign, nonatomic)int height;

@end
