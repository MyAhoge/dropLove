//
//  chatViewController.h
//  dropLove
//
//  Created by Mayday_xy on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface chatViewController : RCConversationViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>




@property(strong,nonatomic)UIButton *changbgBtn;

@property(copy,nonatomic)NSString *DocumentsPath;
@end
