//
//  forgetViewController.m
//  dropLove
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "forgetViewController.h"
#import "dropHeader.h"

@implementation forgetViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = MICOLOR;
   
    [self headerMethod];
    
}


//TODO:控件的搭建
- (void)headerMethod{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = BACK_FRAME;
    [headerView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-80)/2, 30, 80, 20)];
    [headerView addSubview:label];
    label.text = @"重置密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT(18);
    label.textColor = [UIColor whiteColor];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, headerView.frame.origin.y+headerView.frame.size.height+50, WIDTH-20, 40)];
    [self.view addSubview:_phoneText];
    self.phoneText.placeholder = @"请输入手机号";
    self.phoneText.backgroundColor = [UIColor whiteColor];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _phoneText.frame.origin.y+_phoneText.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:sendBtn];
    sendBtn.titleLabel.font = FONT(15);
    [sendBtn setTitle:@"下一步" forState:UIControlStateNormal];
    sendBtn.backgroundColor = COLOR_LOGINBTN;
    [sendBtn addTarget:self action:@selector(sendBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, sendBtn.frame.origin.y+sendBtn.frame.size.height+20, WIDTH-100, 40)];
    [self.view addSubview:lab];
    lab.text = @"我们将向该手机号发送短信验证码，该验证码的有效时间为15分钟";
    lab.textColor = COLOR(167, 167, 172, 1);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font  = FONT(13);
    lab.numberOfLines = 0;
    
}
#pragma mark 发送验证码
- (void)sendBtnMethod{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            forTwoViewController *fortwo = [[forTwoViewController alloc]init];
            fortwo.telePnone = _phoneText.text;
            [self presentViewController:fortwo animated:YES completion:nil];
            
        }else{
            NSLog(@"错误信息：%@",error);
        }
    }];
}
#pragma mark 返回
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark return回收键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark 点击空白回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        [self.view endEditing:YES];
    }
}
@end
