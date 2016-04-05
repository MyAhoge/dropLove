//
//  HomeViewController.h
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dropHeader.h"

@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UILabel *mainLabel;

@property(strong,nonatomic)UILabel *topLabel;

@property(strong,nonatomic)UIButton *changbgBtn;

@property(strong,nonatomic)UIView *middleView;

@property(strong,nonatomic)UIImageView *middleImage;

@property(strong,nonatomic)UIView *personView;

@property(strong,nonatomic)UIView *menuView;

//personView

@property(strong,nonatomic)UIImageView *manimage;

@property(strong,nonatomic)UILabel *mancityLabel;

@property(strong,nonatomic)UILabel *manweatherLabel;

@property(strong,nonatomic)UILabel *mantempLabel;

@property(strong,nonatomic)UIImageView *womanimage;

@property(strong,nonatomic)UILabel *womancityLabel;

@property(strong,nonatomic)UILabel *womanweatherLabel;

@property(strong,nonatomic)UILabel *womantempLabel;

//menuView

@property(strong,nonatomic)UIButton *sharkBtn;

@property(strong,nonatomic)UILabel *sharkLabel;

@property(strong,nonatomic)UIButton *chatBtn;

@property(strong,nonatomic)UILabel *chatLabel;

@property(strong,nonatomic)UIButton *memorialBtn;

@property(strong,nonatomic)UILabel *memorialLabel;

@property(copy,nonatomic)NSString *lastPath;


@property(strong,nonatomic)NSMutableDictionary *weatherMutDic;

@property(copy,nonatomic)NSString *cityNameStr;


@property(strong,nonatomic)NSArray *paths;

@property(copy,nonatomic)NSString *DocumentsPath;
//
//@property(strong,nonatomic)NSFileManager *fileManager;
//@property(copy,nonatomic)NSString *imagePath;
//@property(copy,nonatomic)NSString *originimagePath;

@end
