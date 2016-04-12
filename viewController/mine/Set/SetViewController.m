//
//  SetViewController.m
//  dropLove
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "SetViewController.h"
#import "dropHeader.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *table;

@property (strong, nonatomic)NSArray *arr1;

@property (strong, nonatomic)NSArray *arr2;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr1 = @[@"账号管理",@"账号安全"];
    self.arr2 = @[@"帮助",@"意见反馈",@"关于点滴爱"];
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"设置";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY) style:UITableViewStyleGrouped];
    self.table.delegate =self;
    self.table.dataSource = self;
    self.table.sectionFooterHeight = 5;
    self.table.sectionHeaderHeight = 5;
    [self.view addSubview:_table];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 10;
    }else{
        return 150;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.arr1[indexPath.row];
        cell.textLabel.font = FONT(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.section == 1){
        cell.textLabel.text = self.arr2[indexPath.row];
        cell.textLabel.font = FONT(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       

    }else{
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = COLOR(237, 79, 64, 0.9);
        cell.textLabel.font = FONT(15);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
    
}


/**
 *  点击选中操事件
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        UIAlertController *acl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录吗" preferredStyle:UIAlertControllerStyleActionSheet];
       
        UIAlertAction *aat = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                NSLog(@"确定退出登录");
            
            
            }];
        
        UIAlertAction *aat1 = [UIAlertAction actionWithTitle:@"取消" style:  UIAlertActionStyleCancel handler:nil];
        [acl addAction:aat];
        [acl addAction:aat1];
        
        [self presentViewController:acl animated:YES completion:nil];
        
    }
    
    
}

@end
