//
//  TouchIDViewController.m
//  dropLove
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "dropHeader.h"

@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       self.view.backgroundColor = [UIColor grayColor];
    
    LAContext *context = [[LAContext alloc]init];
    
    NSError *errpr = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errpr]) {
        
        NSLog(@"支持指纹");
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"123" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功");
                
//                self.view1.frame = CGRectMake(0, 568, 320, 568);
                HomeViewController *vc = [[HomeViewController alloc]init];
                [self presentViewController:vc animated:YES completion:nil];
                
            }
        }];
    }

    
}



@end
