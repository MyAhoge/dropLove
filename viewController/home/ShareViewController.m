//
//  ShareViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/7.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "ShareViewController.h"
#import "dropHeader.h"

@interface ShareViewController ()<UMSocialUIDelegate>

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(243, 239, 230, 1);
    
    self.navigationItem.title = @"分享";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                    
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    
                                                                    };
    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
//    rightBtn.tintColor = [UIColor whiteColor];
//    
//    
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, WIDTH-30, 140)];
    
    self.myView.backgroundColor = [UIColor whiteColor];
    
    self.myView.layer.cornerRadius = 10;
    
    self.myView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.myView];
    
    self.fromLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 20, 20)];
    
    self.fromLab.text = @"距";
    
    self.fromLab.font = FONT(15);
    
    self.fromLab.textColor = [UIColor blackColor];
    
    [self.myView addSubview:self.fromLab];
    
    self.shareTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 127, 20)];
    
    self.shareTimeLab.text = self.timeStr;
    
    self.shareTimeLab.textAlignment = NSTextAlignmentLeft;
    
    self.shareTimeLab.font = FONT(15);
    
    self.shareTimeLab.textColor = [UIColor blackColor];
    
    [self.myView addSubview:self.shareTimeLab];
    
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(_myView.frame.size.width/2-45, 50, 90, 20)];
    
    self.contentLab.textAlignment = NSTextAlignmentCenter;
    
    self.contentLab.text = self.contentStr;
    
    self.contentLab.font = FONT(15);
    
    self.contentLab.textColor = [UIColor blackColor];
    
    [self.myView addSubview:self.contentLab];
    
    self.dayLab = [[UILabel alloc]initWithFrame:CGRectMake(_myView.frame.size.width/2-50, 88, 100, 30)];
    
    self.dayLab.textColor= COLOR(64, 203, 255, 1);
    
    self.dayLab.text = self.dayStr;
    
    self.dayLab.font = FONT(28);
    
    self.dayLab.textAlignment = NSTextAlignmentCenter;
    
    [self.myView addSubview:self.dayLab];
    
    self.tianLab = [[UILabel alloc]initWithFrame:CGRectMake(_myView.frame.size.width/2+60, 100, 27, 16)];
    
    self.tianLab.text = @"天了";
    
    self.tianLab.textAlignment = NSTextAlignmentCenter;
    
    self.tianLab.textColor = [UIColor blackColor];
    
    self.tianLab.font = FONT(13);
    
    [self.myView addSubview:self.tianLab];
    
    self.shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 202, WIDTH-30, 44)];
    
    self.shareBtn.backgroundColor = COLOR(64, 203, 255, 1);
    
    [self.view addSubview:self.shareBtn];
    
    self.shareLab = [[UILabel alloc]initWithFrame:CGRectMake(_shareBtn.frame.size.width/2-23,_shareBtn.frame.size.height/2-10 , 46, 20)];

    self.shareLab.textColor = [UIColor whiteColor];
    
    self.shareLab.textAlignment = NSTextAlignmentCenter;
    
    self.shareLab.font = FONT(15);
    
    self.shareLab.text = @"晒一下";
    
    self.shareBtn.layer.cornerRadius = 5;
    
    self.shareBtn.layer.masksToBounds = YES;
    
    [self.shareBtn addTarget:self action:@selector(sharememday) forControlEvents:UIControlEventTouchDown];
    
    [self.shareBtn addSubview:self.shareLab];
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sharememday{
      UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:SHARE_SDK shareText:@"点滴爱" shareImage:image shareToSnsNames:nil delegate:nil];
    
}
-(void)edit:(UIButton *)sender{
    
    editMemorialDayViewController *edit = [[editMemorialDayViewController alloc]init];
    
    edit.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:edit animated:YES];
    
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
