//
//  loginViewController.m
//  dropLove
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "loginViewController.h"
#import "dropHeader.h"

/**
 *  登录
 */
@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = MICOLOR;
    
    [self headerMethod];
    
    [self otherLoginMethod];
}

- (void)headerMethod{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 220)];
    [self.view addSubview:_headerView];
    self.headerView.backgroundColor = COLOR_MINE;
    
    self.headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-100)/2, 40, 100, 100)];
    [self.headerView addSubview:_headerImgView];
    self.headerImgView.image = [UIImage imageNamed:@"logo"];
    self.headerImgView.layer.cornerRadius = 25;
    self.headerImgView.layer.masksToBounds = YES;
    
    self.headerLab = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-130)/2, _headerImgView.frame.size.height+_headerImgView.frame.origin.y+15, 130, 40)];
    [self.headerView addSubview:_headerLab];
    self.headerLab.text = @"点滴爱";
    self.headerLab.font = FONT(18);
    self.headerLab.textColor = [UIColor whiteColor];
    self.headerLab.textAlignment = NSTextAlignmentCenter;
    
    self.textPhone = [[UITextField alloc]initWithFrame:CGRectMake(10, _headerView.frame.origin.y+_headerView.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:_textPhone];
    self.textPhone.placeholder = @"请输入手机号";
    self.textPhone.backgroundColor = [UIColor whiteColor];
    
    self.textPassWord = [[UITextField alloc]initWithFrame:CGRectMake(10, _textPhone.frame.origin.y+_textPhone.frame.size.height+10, WIDTH-20, 40)];
    [self.view addSubview:_textPassWord];
    self.textPassWord.placeholder = @"请输入密码";
    self.textPassWord.backgroundColor = [UIColor whiteColor];
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _textPassWord.frame.origin.y+_textPassWord.frame.size.height+20, WIDTH-20, 40)];
    [self.view addSubview:_loginBtn];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = FONT(18);
    self.loginBtn.backgroundColor = COLOR_LOGINBTN;
    [self.loginBtn addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    
    self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _loginBtn.frame.origin.y+_loginBtn.frame.size.height+20, WIDTH-20, 1)];
    [self.view addSubview:_lineLab];
    self.lineLab.backgroundColor = COLOR(167, 167, 172, 1);
    
    
}
#pragma mark 登录
- (void)loginMethod{
    
    if ([_textPhone.text isEqualToString:@""] || [_textPassWord.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有输入手机号和密码哦！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if (![_textPhone.text isEqualToString:@""] && ![_textPassWord.text isEqualToString:@""]){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *dic = @{@"phone":_textPhone.text,
                                  @"password":_textPassWord.text};
            
            [dataService loginDic:dic andWithSucess:^(NSDictionary *resultDic) {
                NSUserDefaults *userNumber = [NSUserDefaults standardUserDefaults];
                [userNumber setObject:resultDic forKey:@"number"];
                [userNumber setObject:[resultDic objectForKey:@"data"] forKey:@"data"];
                
                NSString *str = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"number"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([str isEqualToString:@"1"]) {
                        marryViewController *marry = [[marryViewController alloc]init];
                        [self presentViewController:marry animated:YES completion:nil];
                    }else if ([str isEqualToString:@"2"]){
                        AppDelegate *appD = [[UIApplication sharedApplication] delegate];
                        [self presentViewController:appD.tabBar animated:YES completion:nil];
                    }
                });
            } andWithFaile:^(NSDictionary *faile) {
                NSLog(@"%@", faile);
            }];
        });
    }
}
- (void)otherLoginMethod{
    
    self.otherLab = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-80)/2, _lineLab.frame.origin.y+_lineLab.frame.size.height+20, 80, 20)];
    [self.view addSubview:_otherLab];
    self.otherLab.text = @"第三方登录";
    self.otherLab.font = FONT(15);
    self.otherLab.textColor = COLOR(121, 121, 121, 1);
    
    self.qqBtn = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH-3*40)/4, _otherLab.frame.size.height+_otherLab.frame.origin.y+20, 40, 40)];
    [self.view addSubview:_qqBtn];
    [self.qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [self.qqBtn addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.sinaBtn= [[UIButton alloc]initWithFrame:CGRectMake(2*(WIDTH-3*40)/4+40, _otherLab.frame.size.height+_otherLab.frame.origin.y+20, 40, 40)];
    [self.view addSubview:_sinaBtn];
    [self.sinaBtn setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    [self.sinaBtn addTarget:self action:@selector(sinaLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake(3*(WIDTH-3*40)/4+40*2, _otherLab.frame.size.height+_otherLab.frame.origin.y+20, 40, 40)];
    [self.view addSubview:_wechatBtn];
    [self.wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [self.wechatBtn addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, HEIGHT-10-20, 70, 20)];
    [self.view addSubview:_forgetBtn];
    [self.forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = FONT(13);
    [self.forgetBtn setTitleColor:COLOR(121, 121, 121, 1) forState:UIControlStateNormal];
    [self.forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-70, HEIGHT-10-20, 70, 20)];
    [self.view addSubview:_registerBtn];
    [self.registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = FONT(13);
    [self.registerBtn setTitleColor:COLOR(121, 121, 121, 1) forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerNew) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)qqLogin{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            marryViewController *marry = [[marryViewController alloc]init];
            
            [self presentViewController:marry animated:YES completion:nil];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
}
- (void)sinaLogin{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            marryViewController *marry = [[marryViewController alloc]init];
            
            [self presentViewController:marry animated:YES completion:nil];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
    

    
}
- (void)wechatLogin{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            marryViewController *marry = [[marryViewController alloc]init];
            
            [self presentViewController:marry animated:YES completion:nil];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }
        
    });
    
  
}
- (void)forget{
    forgetViewController *forget = [[forgetViewController alloc]init];
    
    [self presentViewController:forget animated:YES completion:nil];
    
}
- (void)registerNew{
    registerViewController *regist = [[registerViewController alloc]init];
    [self presentViewController:regist animated:YES completion:nil];
}
//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
