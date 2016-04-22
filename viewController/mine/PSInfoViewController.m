//
//  PSInfoViewController.m
//  dropLove
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "PSInfoViewController.h"
#import "dropHeader.h"

@interface PSInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic)UITableView *table;

@property (copy, nonatomic)NSString *str1;

@property (strong, nonatomic)UIDatePicker *picker;

@property (strong, nonatomic)UIView* view1;

@property (strong, nonatomic)UIView* view2;

@property (strong, nonatomic)UIButton *canclebtn;

@property (strong, nonatomic)UIButton *savebtn;

@property (copy, nonatomic)NSString *birthday;

@property (strong, nonatomic)NSMutableArray *mutarr;

@property (strong, nonatomic)UITextField *textname5;

@property (strong, nonatomic)UILabel *lable;


@end

@implementation PSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    /**
     *  顶部导航
     */
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(addInfo)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    /**
     table
     */
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    self.table.sectionFooterHeight = 5;
    self.table.sectionHeaderHeight = 5;
    [self.view addSubview:_table];
    
    
    /**
     个性签名
     */
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 220, WIDTH_MY, 40)];
    [self.table addSubview:_view2];
    self.view2.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 60, 20)];
    lab.font = FONT(15);
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"个性签名";
    [self.view2 addSubview:lab];
    
    /**
     个性签签名最后箭头
     */
    UIImageView *image5 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY-15-14, 13, 14, 14)];
    image5.image = [UIImage imageNamed:@"111.jpg"];
    [self.view2 addSubview:image5];
    
    
    /**
     个性签名显示
     */
    self.textname5 = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, WIDTH_MY-80-15-10-10, 20)];
    self.textname5.font = FONT(15);
    self.textname5.textAlignment = NSTextAlignmentRight;
    self.textname5.backgroundColor = [UIColor clearColor];
    self.textname5.keyboardType = UIControlStateNormal;
    self.textname5.returnKeyType = UIReturnKeyDone;
    self.lable.textAlignment = NSTextAlignmentRight;
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    NSString *name1 = [defaults1 objectForKey:@"pstextname"];
    self.textname5.text = name1;
    self.textname5.clearButtonMode =  UITextFieldViewModeWhileEditing;
    [self.view2 addSubview:_textname5];
    [self.textname5 addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    //添加手势（点击收回键盘）
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    /**
     点击生日跳转
     */
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_MY, WIDTH_MY, 246)];
    self.view1.backgroundColor = COLOR(237, 79, 64, 1);
    [self.view addSubview:_view1];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, WIDTH_MY-140, 44)];
    titlelab.text = @"选择生日";
    titlelab.font = FONT(18);
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.textColor = [UIColor whiteColor];
    [self.view1 addSubview:titlelab];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 64+216, WIDTH_MY, HEIGHT_MY-64-216)];
    view5.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view1 addSubview:view5];
    
    
    /**
     时间选择器
     */
    self.picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,64, WIDTH_MY, 216)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.datePickerMode =   UIDatePickerModeDate;
    [self.picker addTarget:self action:@selector(seledate) forControlEvents:UIControlEventValueChanged];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.picker.locale = locale;
    
    [self.view1 addSubview:self.picker];
    
    self.canclebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 30)];
    [self.canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    self.canclebtn.titleLabel.font = FONT(15);
    [self.canclebtn addTarget:self action:@selector(cancle) forControlEvents:  UIControlEventTouchUpInside];
    [self.view1 addSubview:_canclebtn];
    
    /**
     保存按钮
     */
    self.savebtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH_MY-10-50, 30, 50, 30)];
    [self.savebtn setTitle:@"保存" forState:UIControlStateNormal];
    self.savebtn.titleLabel.font = FONT(15);
    [self.savebtn addTarget:self action:@selector(save) forControlEvents:  UIControlEventTouchUpInside];
    [self.view1 addSubview:_savebtn];
    
    
    
    
    
}


/**
 *  个性签名保存
 */
- (void)backgroundTap{
    
    NSLog(@"1234");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject: self.textname5.text forKey:@"pstextname"];
    [defaults synchronize];
    
    NSLog(@"%@", self.textname5.text);
    
    NSDictionary *ddd = [[NSDictionary alloc]init];
    ddd = @{@"nsignature":self.textname5.text,
            @"id":@1};
    //    [IcomNSObject birthday:ddd Andicomchange:^(NSDictionary *birthday) {
    //        NSLog(@"修改成功");
    //    }];
    
    [IcomNSObject signature:ddd Andicomchange:^(NSDictionary *signature) {
        NSLog(@"修改成功");
    }];
    
}


/**
 *  点击键盘消失
 *
 */
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
}

/**
 *  table行数
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

/**
 *  table行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
        
    }else{
        
        return 40;
    }
    
    
}

/**
 *  table组高
 *
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

/**
 *  table行点击事件
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        UIAlertController *acl = [UIAlertController alertControllerWithTitle:@"更改性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *aat = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"性别改为男");
            
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"男" forKey:@"pssex"];
            [defaults synchronize];
            [self.table reloadData];
            
            
        }];
        
        UIAlertAction *aat1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"性别改为女");
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"女" forKey:@"pssex"];
            [defaults synchronize];
            [self.table reloadData];
            
        }];
        
        UIAlertAction *aat2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [acl addAction:aat];
        [acl addAction:aat1];
        [acl addAction:aat2];
        [self presentViewController:acl animated:YES completion:nil];
        
    }else if (indexPath.section == 0 && indexPath.row == 3){
        
        
        [UIView animateWithDuration:0.00001 animations:^{
            [self.navigationController setNavigationBarHidden:YES animated:NO];
            self.view1.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
        }];
        
        
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:  UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 60, 60)];
        image.image = [UIImage imageNamed:@"icom.jpg"];
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        cell.accessoryView = image;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        
        PSInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell = [[PSInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        
        cell.textLabel.text = @"昵称";
        
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *name1 = [defaults1 objectForKey:@"pstextname1"];
        cell.textname1.text = name1;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *name1 = [defaults1 objectForKey:@"pssex"];
        
        cell.detailTextLabel.text = name1 ;
        NSLog(@"+++++++++++%@",name1);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }else if (indexPath.section == 0 && indexPath.row == 3){
        
        
        cell.textLabel.text = @"生日";
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *name1 = [defaults1 objectForKey:@"psbirthday"];
        
        cell.detailTextLabel.text = name1;
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    
    
    return cell;
}

/**
 *  个人资料完成按钮
 */
- (void)addInfo{
    
    NSLog(@"添加完成");
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  日期选择器
 */
- (void)seledate{
    
    //NSDate格式转换为NSString格式
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *pickerDate = [self.picker date];
    // 创建一个日期格式器
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    self.birthday = [pickerFormatter stringFromDate:pickerDate];
    
    NSLog(@"选中时间%@",self.birthday);
    
    
}

/**
 *  取消修改生日按钮
 */
- (void)cancle{
    
    
    [UIView animateWithDuration:0.00001 animations:^{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
    }];
    
    NSLog(@"取消");
    
}


/**
 *  保存修改生日按钮
 */
- (void)save{
    
    ClockModel *model = [[ClockModel alloc]init];
    model.psbirthday = self.birthday;
    [self.mutarr addObject:model];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.birthday forKey:@"psbirthday"];
    [defaults synchronize];
    [self.table reloadData];
    
    NSLog(@"保存修改的生日%@",self.birthday);
    NSDictionary *dddbirthday = [[NSDictionary alloc]init];
    dddbirthday = @{@"nbrithday":self.birthday,
                    @"id":@1};
    
    
    [IcomNSObject birthday:dddbirthday Andicomchange:^(NSDictionary *birthday) {
        NSLog(@"修改成功");
    }];
    
    
    
    [UIView animateWithDuration:0.00001 animations:^{
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        
    }];
    
    NSLog(@"保存");
}

/**
 *  键盘隐藏
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return 1;
}


@end

