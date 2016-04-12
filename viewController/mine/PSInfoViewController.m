//
//  PSInfoViewController.m
//  dropLove
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "PSInfoViewController.h"
#import "dropHeader.h"

@interface PSInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *table;

@end

@implementation PSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(addInfo)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;

    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    self.table.sectionFooterHeight = 5;
    self.table.sectionHeaderHeight = 5;
    [self.view addSubview:_table];
    
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }else{
        
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
        
    }else{
        
        return 40;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 60, 60)];
        image.image = [UIImage imageNamed:@"icom.jpg"];
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        cell.accessoryView = image;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        cell.textLabel.text = @"昵称";
        UITextField *nametext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        nametext.font = FONT(15);
        nametext.textAlignment = NSTextAlignmentRight;
        nametext.text = @"jack";
        cell.accessoryView = nametext;
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        
        cell.textLabel.text = @"性别";
        UITextField *nametext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        nametext.font = FONT(15);
        nametext.textAlignment = NSTextAlignmentRight;
        nametext.text = @"男";
        cell.accessoryView = nametext;
        
    }else if (indexPath.section == 0 && indexPath.row == 3){
        
        cell.textLabel.text = @"生日";
        UITextField *nametext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        nametext.font = FONT(15);
        nametext.textAlignment = NSTextAlignmentRight;
        nametext.text = @"1999-09-09";
        cell.accessoryView = nametext;
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        cell.textLabel.text = @"个性签名";
        UITextField *nametext = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        nametext.font = FONT(15);
        nametext.textAlignment = NSTextAlignmentRight;
        nametext.text = @"没有如果";
        cell.accessoryView = nametext;
    }

    return cell;
}


- (void)addInfo{
    
    NSLog(@"添加完成");
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
