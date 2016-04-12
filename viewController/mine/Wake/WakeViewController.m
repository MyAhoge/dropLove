//
//  WakeViewController.m
//  dropLove
//
//  Created by administrator on 16/4/8.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WakeViewController.h"
#import "dropHeader.h"

@interface WakeViewController ()

@property (strong, nonatomic)UIImageView *img1;

@property (strong, nonatomic)UIImageView *img2;

@property (strong, nonatomic)UIImageView *img3;

@property (strong, nonatomic)UILabel *lab1;

@property (strong ,nonatomic)UILabel *lab2;

@end

@implementation WakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"叫ta起床";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, (HEIGHT_MY/2)+30)];
    self.img1.image = [UIImage imageNamed:@"Wake3"];
    [self.view addSubview:_img1];
    
    
    self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2-50-50, (HEIGHT_MY/2)+30+40-10, 50, 50)];
    self.img2.image = [UIImage imageNamed:@"呼叫起床"];
    self.img2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phone)];
    [self.img2 addGestureRecognizer:tap];
    [self.view addSubview:_img2];
    
    
    self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2+50, (HEIGHT_MY/2)+30+40-10, 50, 50)];
    self.img3.image = [UIImage imageNamed:@"起床闹钟"];
    self.img3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clock)];
    [self.img3 addGestureRecognizer:tap2];
    [self.view addSubview:_img3];
    
    self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2-50-60-5, (HEIGHT_MY/2)+30+40+40+20, 70, 20)];
    self.lab1.text = @"起床电话";
    self.lab1.textAlignment = NSTextAlignmentCenter;
    self.lab1.textColor = [UIColor grayColor];
    self.lab1.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_lab1];
    
    self.lab2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2+40, (HEIGHT_MY/2)+30+40+40+20, 70, 20)];
    self.lab2.text = @"定时呼叫";
    self.lab2.textAlignment = NSTextAlignmentCenter;
    self.lab2.textColor = [UIColor grayColor];
    self.lab2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_lab2];
    
    
}

- (void)phone{
    
    NSLog(@"起床电话");
    
    //打电话code
    UIApplication *app = [UIApplication sharedApplication];
    //打电话
    [app openURL:[NSURL URLWithString:@"tel://10010"]];
    
}

- (void)clock{
    
    NSLog(@"闹钟呼叫");
    ClockViewController *clock = [[ClockViewController alloc]init];
    clock.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:clock animated:YES];

}

@end
