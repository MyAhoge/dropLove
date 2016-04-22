//
//  loginViewController.h
//  dropLove
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  登录
 */
@interface loginViewController : UIViewController

@property (strong, nonatomic) UIView      *headerView;

@property (strong, nonatomic) UIImageView *headerImgView;

@property (strong, nonatomic) UILabel     *headerLab;

@property (strong, nonatomic) UITextField *textPhone;

@property (strong, nonatomic) UITextField *textPassWord;

@property (strong, nonatomic) UIButton    *loginBtn;

@property (strong, nonatomic) UILabel     *lineLab;

@property (strong, nonatomic) UILabel     *otherLab;

@property (strong, nonatomic) UIButton    *qqBtn;

@property (strong, nonatomic) UIButton    *sinaBtn;

@property (strong, nonatomic) UIButton    *wechatBtn;

@property (strong, nonatomic) UIButton    *forgetBtn;

@property (strong, nonatomic) UIButton    *registerBtn;

@end
