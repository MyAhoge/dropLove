//
//  NumSafetyViewController.m
//  dropLove
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "NumSafetyViewController.h"
#import "dropHeader.h"
@interface NumSafetyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *table;

@property (strong, nonatomic) UISwitch *switch1;

@property (strong, nonatomic)UIView *view1;


@end

@implementation NumSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"账号安全";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.sectionHeaderHeight = 10;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view addSubview:_table];
    
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10+50, WIDTH, 50)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.table addSubview:_view1];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
    lable.text = @"Touch ID";
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [UIColor blackColor];
    lable.font = FONT(15);
    [self.view1 addSubview:lable];
    
    self.switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH_MY-15-40-10, 10, 40, 30)];
    
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    NSString *Screenpassword1 = [defaults1 objectForKey:@"Screenpassword"];
    if ([Screenpassword1 isEqualToString:@"Screenpassword"]) {
        self.switch1.on = YES;
    }else{
        
        self.switch1.on = NO;
    }
    [self.switch1 addTarget:self action:@selector(add:) forControlEvents: UIControlEventValueChanged];
    [self.view1 addSubview:_switch1];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"数字密码";
        cell.textLabel.font = FONT(15);
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ScreenPasswordViewController *svc = [[ScreenPasswordViewController alloc]init];
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

- (void)add:(id)sender{
    
    if ((self.switch1.on == YES)) {
        NSLog(@"开启指纹解锁");
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *Screenpassword = @"Screenpassword";
        [defaults setObject:Screenpassword forKey:@"Screenpassword"];
        [defaults synchronize];
        
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *Screenpassword1 = [defaults1 objectForKey:@"Screenpassword"];//根据键值取出name
        NSLog(@"读取数据%@",Screenpassword1);

        
    }else{
        
        NSLog(@"关闭指纹解锁");
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *CloseScreenpassword = @"CloseScreenpassword";
        [defaults setObject:CloseScreenpassword forKey:@"Screenpassword"];
        [defaults synchronize];
        
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *Screenpassword1 = [defaults1 objectForKey:@"Screenpassword"];//根据键值取出name
        NSLog(@"*****读取数据%@",Screenpassword1);
        if (Screenpassword1 == nil) {
            NSLog(@"nil");
        }
    }
}

@end
