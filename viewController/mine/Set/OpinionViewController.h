//
//  OpinionViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionViewController : UIViewController<UITextViewDelegate>

@property(strong,nonatomic)UILabel *messageLab;

@property(strong,nonatomic)UITextView *textView;

@property(strong,nonatomic)UILabel *placeholderLab;

@property(strong,nonatomic)UILabel *descriptionLab;

@property(strong,nonatomic)UIButton *commitBtn;


@end
