//
//  SharkViewController.m
//  dropLove
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "SharkViewController.h"
#import "dropHeader.h"
#import "MapViewController.h"

@interface SharkViewController ()

@property (strong, nonatomic)UIImageView *bgimg;
@property (strong, nonatomic)UIImageView *oneimg;
@property (strong, nonatomic)UIImageView *twoimg;
@property (strong, nonatomic)UIImageView *threeimg;
@property (strong, nonatomic)UIImageView *fourimg;
@property (strong, nonatomic)UILabel *resultlab;
@property (strong, nonatomic)UIImageView *sharkimg;
@property (strong, nonatomic)NSArray *arr;
@property (strong, nonatomic)NSArray *arrpic;
@property (strong, nonatomic)UIImageView *resultimg;
@property (strong, nonatomic)UIImageView *resultbgimg;
@property (strong, nonatomic)UILabel *resultnearlab;
@property (strong, nonatomic)UILabel *resultgolab;
@property (strong, nonatomic)NSArray *arrnear;
@property (strong, nonatomic)UIImageView *goimg;
@property (strong, nonatomic)UITapGestureRecognizer *tap;



@end

@implementation SharkViewController
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"摇一摇";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    // 背景图
    self.bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY)];
    self.bgimg.image = [UIImage imageNamed:@"sharkbg1"];
    self.bgimg.alpha = 0.8;
    [self.view addSubview:_bgimg];
    
    // 底部四个小图
    self.oneimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, HEIGHT_MY-164, 50, 50)];
    self.oneimg.image = [UIImage imageNamed:@"1000"];
    self.oneimg.layer.cornerRadius = 25;
    self.oneimg.layer.masksToBounds = YES;
    [self.view addSubview:_oneimg];
    self.twoimg = [[UIImageView alloc]initWithFrame:CGRectMake(15+50+(WIDTH_MY-50-70-70-90-30)/3, HEIGHT_MY-110-10-64, 70, 70)];
    self.twoimg.image = [UIImage imageNamed:@"1002"];
    self.twoimg.layer.cornerRadius = 35;
    self.twoimg.layer.masksToBounds = YES;
    [self.view addSubview:_twoimg];
    self.threeimg = [[UIImageView alloc]initWithFrame:CGRectMake(15+50+70+2*(WIDTH_MY-50-70-70-90-30)/3, HEIGHT_MY-110-64, 70, 70)];
    self.threeimg.image = [UIImage imageNamed:@"1004"];
    self.threeimg.layer.cornerRadius = 35;
    self.threeimg.layer.masksToBounds = YES;
    [self.view addSubview:_threeimg];
    
    self.fourimg = [[UIImageView alloc]initWithFrame:CGRectMake(15+50+70+70+3*(WIDTH_MY-50-70-70-90-30)/3, HEIGHT_MY-130-64, 90, 90)];
    self.fourimg.image = [UIImage imageNamed:@"1005"];
    self.fourimg.layer.cornerRadius = 45;
    self.fourimg.layer.masksToBounds = YES;
    [self.view addSubview:_fourimg];
    
    
    // 摇一摇图片
    self.sharkimg = [[UIImageView alloc]initWithFrame:CGRectMake(60, (HEIGHT_MY/2-(WIDTH_MY-120)/2)-64, WIDTH_MY-120, WIDTH_MY-120)];
    self.sharkimg.layer.cornerRadius = (WIDTH_MY-120)/2;
    self.sharkimg.layer.masksToBounds = YES;
    self.sharkimg.image = [UIImage imageNamed:@"2001"];
    self.sharkimg.alpha = 1;
    [self.view addSubview:_sharkimg];
    
    
    self.arr = @[@"去公园",@"吃火锅",@"看电影",@"吃海鲜",@"唱K"];
    self.arrpic = @[@"1000",@"1001",@"1002",@"1004",@"1005"];
    self.arrnear = @[@"附近公园",@"附近火锅店",@"附近电影院",@"附近海鲜店",@"附近KTV"];
    
    
    //  显示摇出结果文字内容
    self.resultlab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, 60, 100, 35)];
    self.resultlab.textAlignment = NSTextAlignmentCenter;
    self.resultlab.font = [UIFont systemFontOfSize:30];
    self.resultlab.textColor = [UIColor grayColor];
    
    
    
    // 显示摇出结果图片
    self.resultimg = [[UIImageView alloc]initWithFrame:CGRectMake(70, HEIGHT_MY/2-(WIDTH_MY-140)/2-70, WIDTH_MY-140, WIDTH_MY-140)];
    self.resultimg.layer.cornerRadius = (WIDTH_MY-140)/2;
    self.resultimg.layer.masksToBounds = YES;
    self.resultimg.alpha = 0.8;
    
    // 显示附近地方lab
    self.resultnearlab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2-150, HEIGHT_MY/2+90+40, 150, 30)];
    self.resultnearlab.font = [UIFont systemFontOfSize:25];
    self.resultnearlab.textAlignment = NSTextAlignmentCenter;
    self.resultnearlab.textColor = [UIColor grayColor];
    
    // 显示导航图标
    self.resultgolab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2+20, HEIGHT_MY/2+90+40, 60, 30)];
    self.resultgolab.font = [UIFont systemFontOfSize:25];
    self.resultnearlab.textAlignment = NSTextAlignmentCenter;
    self.resultgolab.textColor = [UIColor grayColor];
    self.resultgolab.text = @"导航";
    
    //  显示导航图标
    self.goimg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2+20+60, HEIGHT_MY/2+90+30, 50, 50)];
    self.goimg.layer.cornerRadius = 25;
    self.goimg.layer.masksToBounds = YES;
    self.goimg.userInteractionEnabled = YES;
    self.goimg.image = [UIImage imageNamed:@"200"];
    //    [self.view addSubview:_goimg];
    //    [self.resultbgimg addSubview:_goimg];
    
    // 创建手势
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test)];
    self.tap.numberOfTapsRequired = 1;
    self.tap.numberOfTouchesRequired = 1;
    [self.goimg addGestureRecognizer:_tap];
    
    
}

//  开始摇一摇
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    NSLog(@"开始摇动");
}


// 结束摇一摇
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    NSLog(@"结束摇动");
    
    self.resultbgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY)];
    self.resultbgimg.backgroundColor = COLOR(243,239,230,1);
    [self.view addSubview:_resultbgimg];
    
    int i = arc4random()%self.arr.count;
    
    NSLog(@"%d",i);
    
    self.resultlab.text = self.arr[i];
    [self.resultbgimg addSubview:_resultlab];
    NSLog(@"%@",self.arr[i]);
    
    self.resultimg.image = [UIImage imageNamed:self.arrpic[i]];
    [self.resultbgimg addSubview:_resultimg];
    NSLog(@"%@",self.arrpic[i]);
    
    
    self.resultnearlab.text = self.arrnear[i];
    [self.resultbgimg addSubview:_resultnearlab];
    [self.resultbgimg addSubview:_resultgolab];
    
    //    self.goimg.image = [UIImage imageNamed:@"200"];
    //    [self.goimg addGestureRecognizer:_tap];
    [self.view addSubview:_goimg];
    
    
}

//  进入导航页面
- (void)test{
    
    NSLog(@"进入导航页面");
    
    MapViewController *vc = [[MapViewController alloc]init];
    vc.citytext = self.city;
    NSString *str4 = [self.resultnearlab.text substringFromIndex:2];
    NSString *str5 = [NSString stringWithFormat:@"%@%@",self.detaladress,str4];
    vc.activeandadress =  str5;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
