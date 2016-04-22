//
//  ScreenPasswordViewController.m
//  dropLove
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "ScreenPasswordViewController.h"
#import "dropHeader.h"

@interface ScreenPasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic)UITableView *table;
@property (strong, nonatomic)UITextField *textfield1;
@property (strong, nonatomic)UITextField *textfield2;
@property (strong, nonatomic)UITextField *textfield3;
@property (strong, nonatomic)UITextField *textfield4;

@property (strong, nonatomic)UILabel *lable1;
@property (strong, nonatomic)UILabel *lable2;
@property (strong, nonatomic)UILabel *lable3;
@property (strong, nonatomic)UILabel *lable4;
@property (strong, nonatomic)NSTimer *timer;

@end

@implementation ScreenPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"设置数字密码";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithTitle:@"保存" style: UIBarButtonItemStylePlain target:self action:@selector(save)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc]initWithTitle:@"取消" style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;


    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY)];
    self.table.delegate = self;
    self.table.dataSource =self;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    self.table.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_table];
    
    self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, 30, 30)];
    self.lable1.font = FONT(25);
    [self.table addSubview:_lable1];
    self.lable1.textAlignment = NSTextAlignmentCenter;
    self.lable1.backgroundColor = COLOR(201, 204, 208, 1);
    
    self.lable2 = [[UILabel alloc]initWithFrame:CGRectMake(50+30+(WIDTH_MY-100-120)/3, 80, 30, 30)];
    self.lable2.font = FONT(25);
    [self.table addSubview:_lable2];
    self.lable2.textAlignment = NSTextAlignmentCenter;
    self.lable2.backgroundColor = COLOR(201, 204, 208, 1);


    self.lable3 = [[UILabel alloc]initWithFrame:CGRectMake(50+30+(WIDTH_MY-100-120)/3*2+30, 80, 30, 30)];
    self.lable3.font = FONT(25);
    [self.table addSubview:_lable3];
    self.lable3.textAlignment = NSTextAlignmentCenter;
    self.lable3.backgroundColor = COLOR(201, 204, 208, 1);


    self.lable4 = [[UILabel alloc]initWithFrame:CGRectMake(50+30+(WIDTH_MY-100-120)+30+30, 80, 30, 30)];
    self.lable4.font = FONT(25);
    [self.table addSubview:_lable4];
    self.lable4.textAlignment = NSTextAlignmentCenter;
    self.lable4.backgroundColor = COLOR(201, 204, 208, 1);

    
    self.textfield3 = [[UITextField alloc]initWithFrame:CGRectMake(-100, 0, 30, 30)];
    self.textfield3.font = FONT(25);
    self.textfield3.textColor = COLOR(243, 239, 230, 1);
    [self.table addSubview:_textfield3];
    self.textfield3.keyboardType = UIKeyboardTypeNumberPad;
 
    [self timestar];
    

}

- (void)timestar{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(add) userInfo:nil repeats:YES];


}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textfield3 becomeFirstResponder];
    
}

- (void)add{
    
    if (self.textfield3.text.length >= 1) {
        self.lable1.text = [self.textfield3.text substringWithRange:NSMakeRange(0, 1)];
    }else{
        self.lable1.text = @"";
    }

    
    if (self.textfield3.text.length >= 2) {
         self.lable2.text = [self.textfield3.text substringWithRange:NSMakeRange(1, 1)];
    }else{
         self.lable2.text = @"";
    }
    
    if (self.textfield3.text.length >= 3) {
        self.lable3.text = [self.textfield3.text substringWithRange:NSMakeRange(2, 1)];
    }else{
        self.lable3.text = @"";
    }

    if (self.textfield3.text.length >= 4) {
        self.lable4.text = [self.textfield3.text substringWithRange:NSMakeRange(3, 1)];
    }else{
        self.lable4.text = @"";
    }


}

- (void)save{
    
    if (self.textfield3.text.length >= 4) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *num = [self.textfield3.text substringToIndex:4];
        NSLog(@"%@",num);
        [defaults setObject:num forKey:@"lockpassword"];
        [defaults synchronize];
        
        NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
        NSString *name1 = [defaults1 objectForKey:@"lockpassword"];//根据键值取出name
        NSLog(@"读取数据%@",name1);
        
        [self.timer invalidate];
        
         self.timer = nil;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}

- (void)back{
    
     [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
    
    
}
@end
