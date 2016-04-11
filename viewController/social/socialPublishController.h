//
//  socialPublishController.h
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialViewController.h"

@protocol turnBackDelegate <NSObject>
- (void)turnImages:(NSMutableArray *)selectAllImages;
@end

@interface socialPublishController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,turnBackDelegate>

@property (assign, nonatomic) id<socialDelegate> delegate;

@property (strong, nonatomic) UIButton *addImageBtn;
@property (strong, nonatomic) UIScrollView *imageScroll;
@property (strong, nonatomic) NSMutableArray *imageViewArr;
@property (strong, nonatomic) UIButton *deleteBtn;

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
