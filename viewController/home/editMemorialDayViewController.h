//
//  editMemorialDayViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "memorialViewController.h"

@interface editMemorialDayViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)UIView *editView;

@property(strong,nonatomic)UILabel *memLab;

@property(strong,nonatomic)UILabel *timeLab;

@property(strong,nonatomic)UILabel *lineLab;

@property(strong,nonatomic)UILabel *textLab;

@property (nonatomic,strong)UIDatePicker *datePicker;

@property(strong,nonatomic)UIButton *showBtn;

@property(assign,nonatomic)int i;

@property(assign,nonatomic)id<editMemdatDelegate>delegate;

@property(copy,nonatomic)NSString *str;

@property(strong,nonatomic)NSString * dateString;
@end
