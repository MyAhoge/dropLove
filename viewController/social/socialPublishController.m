//
//  socialPublishController.m
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialPublishController.h"
#import "dropHeader.h"


@implementation socialPublishController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self topMethod];
    
    
}

- (void)topMethod{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 25)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    
//    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-30, 12, 60, 20)];
//    [headerView addSubview:headerLabel];
//    headerLabel.text = @"社区";
//    headerLabel.font = FONT(15);
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-24-10, 12, 30, 20)];
    [headerView addSubview:photoBtn];
    photoBtn.titleLabel.font = FONT(15);
    [photoBtn setTitle:@"发布" forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)add{
    
}
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
