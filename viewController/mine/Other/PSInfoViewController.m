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

@property (strong, nonatomic)UIButton *canclebtn;

@property (strong, nonatomic)UIButton *savebtn;

@property (copy, nonatomic)NSString *birthday;

@property (strong, nonatomic)NSMutableArray *mutarr;


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
    
    
    self.savebtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH_MY-10-50, 30, 50, 30)];
    [self.savebtn setTitle:@"保存" forState:UIControlStateNormal];
    self.savebtn.titleLabel.font = FONT(15);
     [self.savebtn addTarget:self action:@selector(save) forControlEvents:  UIControlEventTouchUpInside];
    [self.view1 addSubview:_savebtn];

    
    
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
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        UIAlertController *acl = [UIAlertController alertControllerWithTitle:@"更改性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *aat = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"性别改为男");
            
            ClockModel *model = [[ClockModel alloc]init];
            model.pssex = @"男";
            [self.mutarr addObject:model];
            [self.table reloadData];
            
        }];
        
        UIAlertAction *aat1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"性别改为女");
            
            
            ClockModel *model = [[ClockModel alloc]init];
            model.pssex = @"女";
            [self.mutarr addObject:model];
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
//        
//        [UIView animateWithDuration:1 delay:5 options:    UIViewAnimationOptionAllowUserInteraction  animations:^{
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
////            self.view1.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
//
//        } completion:nil];
//        
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        PSInfoTableViewCell *cell = [[PSInfoTableViewCell alloc]init];
        
        cell.textname.returnKeyType = UIReturnKeyDone;
        cell.textname.delegate = self;
        
        
    }
    

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PSInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[PSInfoTableViewCell alloc]initWithStyle:  UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 60, 60)];
        image.image = [UIImage imageNamed:@"icom.jpg"];
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        cell.accessoryView = image;
    }else if (indexPath.section == 0 && indexPath.row == 1){

        cell.namelab.text = @"昵称";
        cell.textname.text = @"名字";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    }else if (indexPath.section == 0 && indexPath.row == 2){
        
        cell.textname.userInteractionEnabled = NO;
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = @"男";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    }else if (indexPath.section == 0 && indexPath.row == 3){
        
        cell.textname.userInteractionEnabled = NO;
        cell.textLabel.text = @"生日";
        cell.detailTextLabel.text = @"1999-09-09";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        cell.namelab.text = @"个性签名";
        cell.textname.text = @"没有如果";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    }

    return cell;
}


- (void)addInfo{
    
    NSLog(@"添加完成");
    
    [self.navigationController popViewControllerAnimated:YES];
}

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

- (void)cancle{
    
//    [UIView animateWithDuration:0.00001 animations:^{
//       
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
//        
//
//    }];
//    
    
    
    [UIView animateWithDuration:0.00001 animations:^{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
    }];

    
    
    
    
    NSLog(@"取消");
    
}

- (void)save{
    
    ClockModel *model = [[ClockModel alloc]init];
    model.psbirthday = self.birthday;
    [self.mutarr addObject:model];
    [self.table reloadData];
    
    
    [UIView animateWithDuration:0.00001 animations:^{
        
     [self.navigationController setNavigationBarHidden:NO animated:NO];
     self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        
    }];

    NSLog(@"保存");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return 1;
}


@end
