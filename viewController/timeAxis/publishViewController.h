//
//  publishViewController.h
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeAxisViewController.h"
@interface publishViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (assign, nonatomic) id<sendDicDelegate> delegate;


@property (copy, nonatomic  ) NSString       *textStr;

@property (strong, nonatomic) UIImageView    *imageView;

@property (copy, nonatomic  ) NSString       *homePath;

@property (strong, nonatomic) NSDictionary   *dic;

@property (strong, nonatomic) UITextView     *text1;

@property (copy, nonatomic  ) NSString       *cityNameStr;

@property (strong, nonatomic) UILabel        *cityLabel;

@property (copy, nonatomic  ) NSString       *prettyVersion;

@property (strong, nonatomic) NSMutableArray *imgArr;

@end
