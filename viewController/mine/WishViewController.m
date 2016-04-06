//
//  WishViewController.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WishViewController.h"
#import "dropHeader.h"
#import "WishTableViewCell.h"

@interface WishViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *table;

@end

@implementation WishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    //  顶部导航栏
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
        topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 25)];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal ];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, WIDTH_MY-160, 44)];
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.text = @"我们的愿望";
    titlelab.textColor = [UIColor whiteColor];
    [headerView addSubview:titlelab];
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH_MY-49, 10, 40, 20)];
    [addbtn setTitle:@"添加" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(addwish) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addbtn];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_MY, HEIGHT_MY-64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_table];
    self.table.sectionHeaderHeight = 5;
    self.table.sectionFooterHeight = 5;
    self.table.delegate = self;
    self.table.dataSource =self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _height;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    WishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentlab.text = @"还看见了ljksgksjks课结束后的购房款排山倒海评审会给对方是可怕的行列好个屁啥电话苹果花盛开的花豆腐干上课还碰到过 第三和空间候和孤苦伶仃付过款那个还开始的；个和数据库的会更好斯蒂芬库里个会尽快是否会给康师傅和可能；京东方可能会的故事啦待会";
    cell.datelab.text = @"2016-04-05 15:34";
    cell.placelab.text = @"苏州高博教育";
    cell.image.backgroundColor = [UIColor purpleColor];
    [cell setHeight:cell.contentlab.text];
    self.height = cell.frame.size.height;
    NSLog( @"%d",_height);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//  返回按钮
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  添加愿望
- (void)addwish{
    
    NSLog(@"添加愿望");
}



@end
