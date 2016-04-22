//
//  invitationViewController.m
//  dropLove
//
//  Created by administrator on 16/4/15.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "invitationViewController.h"
#import "dropHeader.h"
#import "AppDelegate.h"


@implementation invitationViewController


- (void)viewDidLoad{
    
    self.view.backgroundColor = MICOLOR;
    
    [self headerInviMethod];
    
    [self contentInvitationMethod];
    
}
- (void)headerInviMethod{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backMarryBtn = BACK_FRAME;
    [headerView addSubview:backMarryBtn];
    [backMarryBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backMarryBtn addTarget:self action:@selector(inbackMarryMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40, 30, 80, 20)];
    [headerView addSubview:titleLab];
    titleLab.text = @"匹配信息";
    titleLab.font = FONT(18);
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    
}

- (void)contentInvitationMethod{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 64+50, 200, 40)];
    [self.view addSubview:label];
    label.text = @"输入邀请码进入点滴爱";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR(167, 167, 162, 1);
    label.font = FONT(13);
    
    self.numText = [[UITextField alloc]initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height+50, WIDTH-20, 40)];
    [self.view addSubview:_numText];
    self.numText.placeholder = @"请输入邀请码";
    self.numText.backgroundColor = [UIColor whiteColor];
    self.numText.textAlignment = NSTextAlignmentCenter;
    self.numText.textColor = COLOR_MINE;
    self.numText.font = FONT(30);
    //提交
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _numText.frame.origin.y+_numText.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:submitBtn];
    submitBtn.backgroundColor = COLOR_LOGINBTN;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = FONT(15);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)submitBtnMethod{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([_numText.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有输入邀请码哦！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSDictionary *dic = @{@"number":_numText.text,
                              @"userid":[[userDef objectForKey:@"data"] objectForKey:@"user_id"]};
        
        [dataService invitationDic:dic andWithSucess:^(NSDictionary *resultDic) {
            NSLog(@"submit--%@", resultDic);
            if ([[resultDic objectForKey:@"code"] isEqualToString:@"200"]) {
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                [userDef setObject:@"YES" forKey:@"user"];
                
                AppDelegate *appD = [[UIApplication sharedApplication] delegate];
                [self presentViewController:appD.tabBar animated:YES completion:nil];
            }
        } andWithFaile:^(NSDictionary *faile) {
            
        }];
    }
}
- (void)inbackMarryMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
