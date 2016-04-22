//
//  NoticeViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "NoticeViewController.h"
#import "dropHeader.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
//    self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    self.title = @"通知";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self initTableView];
    
    


}
//初始化tableView;
-(void)initTableView{
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    
    self.table.backgroundColor = COLOR(243,239,230,1);
    
    self.table.delegate = self;
    
    self.table.dataSource = self;
    
    [self.view addSubview:self.table];
    //cell 无线
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
 
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//每组几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//每行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
    }
    cell.lab.text = @"1.欢迎来到点滴爱";
    [cell setHeight:cell.lab.text];
    self.height = cell.frame.size.height;
    return cell;
}
//每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
