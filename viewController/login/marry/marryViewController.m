//
//  marryViewController.m
//  dropLove
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "marryViewController.h"
#import "dropHeader.h"
/**
 *  匹配
 */
@implementation marryViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = MICOLOR;
    
    [self registMethod];
    
    [self headerMethod];
    
    [self contentMethod];
    
}
- (void)headerMethod{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = BACK_FRAME;
    [headerView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backLoginMethod) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-80)/2, 30, 80, 20)];
    [headerView addSubview:label];
    label.text = @"匹配信息";
    label.textColor = [UIColor whiteColor];
    label.font = FONT(18);
}

- (void)contentMethod{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 84, 200, 40)];
    [self.view addSubview:label];
    label.text = @"点滴爱是情侣两人之间的应用邀请另一半开通吧！";
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT(13);
    
    UIButton *requestBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:requestBtn];
    [requestBtn setTitle:@"邀请另一半" forState:UIControlStateNormal];
    [requestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    requestBtn.backgroundColor = COLOR_LOGINBTN;
    [requestBtn addTarget:self action:@selector(requestMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *invitationBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, requestBtn.frame.origin.y+requestBtn.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:invitationBtn];
    [invitationBtn setTitle:@"我已被邀请" forState:UIControlStateNormal];
    [invitationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    invitationBtn.backgroundColor = COLOR_LOGINBTN;
    [invitationBtn addTarget:self action:@selector(invitationMethod) forControlEvents:UIControlEventTouchUpInside];
}
- (void)requestMethod{
    requestViewController *requ = [[requestViewController alloc]init];
    [self presentViewController:requ animated:YES completion:nil];
}
- (void)invitationMethod{
    invitationViewController *invitation = [[invitationViewController alloc]init];
    [self presentViewController:invitation animated:YES completion:nil];
}
#pragma mark 注册-网络请求
- (void)registMethod{
    if (_phone !=nil && _password != nil) {
        NSDictionary *dic = @{@"phone":_phone,
                              @"password":_password};
        [dataService registDic:dic andWithSucess:^(NSDictionary *resultDic) {
            NSLog(@"注册成功！");
        } andWithFaile:^(NSDictionary *faile) {
            
        }];
    }else{
        
    }
}
#pragma mark 修改密码
- (void)changeMethod{
    if (![_phoneChange isEqualToString:@""] && ![_passwordChange isEqualToString:@""]) {
        NSDictionary *dic = @{@"phone":_phone,
                              @"password":_password};
        [dataService changePasswordDic:dic andWithSucess:^(NSDictionary *resultDic) {
            if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"result"]] isEqualToString:@"1"]) {
                NSLog(@"修改密码成功！");
            }
        } andWithFaile:^(NSDictionary *faile) {
            
        }];
    }else{
        
    }
}
- (void)backLoginMethod{
    loginViewController *loginVc = [[loginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
}
@end
