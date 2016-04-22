//
//  AboutViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/14.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "AboutViewController.h"
#import "dropHeader.h"

@interface AboutViewController ()<UMSocialUIDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"关于点滴爱";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-50, 20, 100, 100)];
    
    self.imageView.image = [UIImage imageNamed:@"logo.png"];
    
    self.imageView.layer.cornerRadius = 15;
    
    self.imageView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.imageView];
    
    self.aboutLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, 130, 100, 20)];
    
    self.aboutLab.text = @"点滴爱 1.1.0";
    
    self.aboutLab.textAlignment =NSTextAlignmentCenter;
    
    self.aboutLab.textColor = COLOR(167, 167, 172, 1);
    
    self.aboutLab.font = FONT(12);
    
    [self.view addSubview:self.aboutLab];
    
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 200,WIDTH-20 , 45)];
    
    self.shareBtn.backgroundColor = COLOR_LOGINBTN;
    
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal ];
    
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.layer.cornerRadius = 5;
    
    [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.shareBtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:SHARE_SDK
                                      shareText:@"一款叫点滴爱的情侣软件，可以免费畅聊，记录恩爱纪念日，快找个人一起用吧！"
                                     shareImage:[UIImage imageNamed:@"logo.jpg"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToQQ,nil]
                                       delegate:self];
    
//     [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//    [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
//    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    
    
}
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
