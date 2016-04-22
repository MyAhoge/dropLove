//
//  forTwoViewController.m
//  dropLove
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "forTwoViewController.h"
#import "dropHeader.h"

@implementation forTwoViewController


- (void)viewDidLoad{
    self.view.backgroundColor = MICOLOR;
    
    [self contentTwoMethod];
    
}

- (void)contentTwoMethod{
    
    UIView *headerTwoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headerTwoView];
    headerTwoView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = BACK_FRAME;
    [headerTwoView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-80)/2, 30, 80, 20)];
    [headerTwoView addSubview:label];
    label.text = @"重置密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = FONT(18);
    
    self.verificationCodeText = [[UITextField alloc]initWithFrame:CGRectMake(10,  headerTwoView.frame.origin.y+headerTwoView.frame.size.height+50, WIDTH-20, 40)];
    [self.view addSubview:_verificationCodeText];
    self.verificationCodeText.placeholder = @"请输入验证码";
    self.verificationCodeText.backgroundColor = [UIColor whiteColor];
    
    self.passwordText = [[UITextField alloc]initWithFrame:CGRectMake(10, _verificationCodeText.frame.origin.y+_verificationCodeText.frame.size.height+10, WIDTH-20, 40)];
    [self.view addSubview:_passwordText];
    self.passwordText.placeholder = @"请输入密码";
    self.passwordText.backgroundColor = [UIColor whiteColor];
    
    self.passwordTwoText = [[UITextField alloc]initWithFrame:CGRectMake(10, _passwordText.frame.origin.y+_passwordText.frame.size.height+10, WIDTH-20, 40)];
    [self.view addSubview:_passwordTwoText];
    self.passwordTwoText.placeholder = @"请确认密码";
    self.passwordTwoText.backgroundColor = [UIColor whiteColor];
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _passwordTwoText.frame.origin.y+_passwordTwoText.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:_registerBtn];
    [self.registerBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = COLOR_LOGINBTN;
    [self.registerBtn addTarget:self action:@selector(registerMethod) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
}

#pragma mark 点击改变密码
- (void)registerMethod{
    
    [SMSSDK commitVerificationCode:self.verificationCodeText.text phoneNumber:_telePnone zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
            //验证成功，修改密码，跳到下一页
            NSDictionary *dic = @{@"phone":_telePnone,
                                  @"newpassword":_passwordTwoText.text};
            [dataService changePasswordDic:dic andWithSucess:^(NSDictionary *resultDic) {
                marryViewController *marry = [[marryViewController alloc]init];
                marry.phoneChange = _telePnone;
                marry.passwordChange = _passwordText.text;
                [self presentViewController:marry animated:YES completion:nil];
            } andWithFaile:^(NSDictionary *faile) {
                
            }];
        }else{
            NSLog(@"错误信息:%@",error);
        }
    }];
}
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//return回收键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//点击空白回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        [self.view endEditing:YES];
    }
}
@end
