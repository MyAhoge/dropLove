//
//  NumSetViewController.m
//  dropLove
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "NumSetViewController.h"
#import "dropHeader.h"
@interface NumSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UIImageView *imageman;

@property (strong, nonatomic)UIImageView *imagewoman;

@property (strong, nonatomic)UIImageView *imagelove;

@property (strong, nonatomic)UIButton *relievebtn;

@property (strong, nonatomic)UILabel *promptlable;

@property (strong, nonatomic)UILabel *manlab;

@property (strong, nonatomic)UILabel *womanlab;

@property (strong, nonatomic)UITableView *table;

@end

@implementation NumSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"账号管理";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY) style:UITableViewStyleGrouped];
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view addSubview:_table];
    
    self.imagelove = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2-25, 50, 50, 50)];
    self.imagelove.image = [UIImage imageNamed:@"love"];
    [self.table addSubview:_imagelove];
    
    self.imageman = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2-25-20-70, 40, 70, 70)];
    self.imageman.image = [UIImage imageNamed:@"man.jpg"];
    [self.table addSubview:_imageman];
    
    self.imagewoman = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2+25+20, 40, 70, 70)];
    self.imagewoman.image = [UIImage imageNamed:@"woman.jpg"];
    [self.table addSubview:_imagewoman];
    
    self.manlab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2-25-20-70, 40+70+10, 70, 20)];
    self.manlab.textColor = [UIColor blackColor];
    self.manlab.textAlignment = NSTextAlignmentCenter;
    self.manlab.font = FONT(13);
    self.manlab.text = @"罗密欧";
    [self.table addSubview:_manlab];
    
    self.womanlab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_MY/2+25+20, 40+70+10, 70, 20)];
    self.womanlab.textColor = [UIColor blackColor];
    self.womanlab.textAlignment = NSTextAlignmentCenter;
    self.womanlab.font = FONT(13);
    self.womanlab.text = @"朱丽叶";
    [self.table addSubview:_womanlab];
    
    self.relievebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 70+180, WIDTH_MY-20, 45)];
    [self.relievebtn setTintColor:[UIColor whiteColor]];
    [self.relievebtn setTitle:@"解除关系" forState: UIControlStateNormal];
    self.relievebtn.layer.cornerRadius = 3;
    self.relievebtn.layer.masksToBounds = YES;
    [self.relievebtn addTarget:self action:@selector(relieve) forControlEvents:UIControlEventTouchUpInside];
    self.relievebtn.backgroundColor = COLOR(42, 206, 34, 1);
    self.relievebtn.titleLabel.font = FONT(15);
    [self.table addSubview:_relievebtn];
    
    
    self.promptlable = [[UILabel alloc]initWithFrame:CGRectMake(70, 80+180+80, WIDTH_MY-140, 50)];
    self.promptlable.font = FONT(13);
    self.promptlable.textColor = [UIColor grayColor];
    self.promptlable.text = @"失去的爱不能回头解除关系将删除所有数据";
    self.promptlable.textAlignment = NSTextAlignmentCenter;
    self.promptlable.numberOfLines = 0;
    [self.table addSubview:_promptlable];
    
    
    
}

- (void)relieve{
    
    UIAlertController *acl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定解除关系吗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *aat = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
     NSLog(@"确定解除关系");
    }];
    
    UIAlertAction *att1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [acl addAction:aat];
    [acl addAction:att1];
    
    [self presentViewController:acl animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}
@end
