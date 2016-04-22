//
//  requestViewController.m
//  dropLove
//
//  Created by administrator on 16/4/15.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "requestViewController.h"
#import "dropHeader.h"

@implementation requestViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = MICOLOR;
    
    [self headerRequestMethod];
    
    [self contentRequestMethod];
    
    [self getNumberMethod];
}
-(void)getNumberMethod{
    NSUserDefaults *userNumber = [NSUserDefaults standardUserDefaults];
    NSDictionary *numDic = [userNumber objectForKey:@"number"];
    NSString *numStr = [[numDic objectForKey:@"data"] objectForKey:@"user_number"];
    if (![[NSString stringWithFormat:@"%@",numStr] isEqualToString:@""]) {
        self.numLab.text = numStr;
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *dic = @{@"userid":@"9"};
            
            [dataService getNumberDic:dic andWithSucess:^(NSDictionary *resultDic) {
                NSLog(@"%@", resultDic);
                self.numberStr = [resultDic objectForKey:@"number"];
                //返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.numLab.text = _numberStr;
                    
                    NSUserDefaults *userNumber = [NSUserDefaults standardUserDefaults];
                    [userNumber setObject:_numberStr forKey:@"number"];
                    
                });
            } andWithFaile:^(NSDictionary *faile) {
                
            }];
        });
    }
}
#pragma mark 返回参数 已加入表中
//{
//    "code": "200",
//    "reason": "sucess",
//    "number": "226425"
//}
- (void)headerRequestMethod{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backMarryBtn = BACK_FRAME;
    [headerView addSubview:backMarryBtn];
    [backMarryBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backMarryBtn addTarget:self action:@selector(backMarryMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40, 30, 80, 20)];
    [headerView addSubview:titleLab];
    titleLab.text = @"匹配信息";
    titleLab.font = FONT(18);
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    UIButton *newBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-40, 30, 40, 20)];
    [headerView addSubview:newBtn];
    [newBtn addTarget:self action:@selector(reloadBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [newBtn setTitle:@"刷新" forState:UIControlStateNormal];
    newBtn.titleLabel.font = FONT(18);
    [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
- (void)contentRequestMethod{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 64+50, 200, 40)];
    [self.view addSubview:label];
    label.text = @"通知另一半注册点滴爱，并填写以下邀请码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR(167, 167, 162, 1);
    label.font = FONT(13);
    label.numberOfLines = 2;
    
    self.numLab = [[UILabel alloc]initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height+50, WIDTH-20, 40)];
    [self.view addSubview:_numLab];
    self.numLab.text = @"000000";
    self.numLab.backgroundColor = [UIColor whiteColor];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.textColor = COLOR_MINE;
    self.numLab.font = FONT(30);
}
//刷新
- (void)reloadBtnMethod{
    
    NSDictionary *dic = @{@"number":_numLab.text,
                          @"userid":@"1"};
    [dataService requestDic:dic andWithSucess:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"code"] isEqualToString:@"200"]) {
            
            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
            [userDef setObject:@"YES" forKey:@"user"];
            [userDef setObject:resultDic forKey:@"message"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"number"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            AppDelegate *appD = [[UIApplication sharedApplication] delegate];
            [self presentViewController:appD.tabBar animated:YES completion:nil];
        }
    } andWithFaile:^(NSDictionary *faile) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 100, 200, 60)];
        [self.view addSubview:lab];
        lab.text = @"ta还没有填写邀请码哦,快邀请ta吧！";
        lab.numberOfLines = 2;
    }];
}
- (void)backMarryMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
