//
//  MineViewController.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "MineViewController.h"
#import "dropHeader.h"
//#import "XXXPlistLocalInfo.h"
//#import "IcomNSObject.h"
//#import "WishViewController.h"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *myDataArray;

@property (nonatomic, strong) NSMutableArray *myDataArray1;

@property (strong, nonatomic) UIImageView *icompic;

@property (strong, nonatomic) UIImageView *icompic1;

@property (strong, nonatomic) UILabel *namelab;

@property (strong, nonatomic) UIButton *leftbtn;

@property (strong, nonatomic) UIButton *rightbtn;

@property (assign, nonatomic) int i;

@property (assign, nonatomic) int j;

@property (copy, nonatomic) NSString *localpath;

@property (copy, nonatomic) NSString *lastpath;

@property (strong, nonatomic) NSDictionary *dic;

@property (strong, nonatomic) NSMutableDictionary *mutdic;


@end


@implementation MineViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.i = 1;
    self.j = 1;
    self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    // plist
    PlistLocalInfo *localinfo = [[PlistLocalInfo alloc]init];
    self.localpath = [localinfo userInfoPath];
    self.lastpath = [_localpath stringByAppendingPathComponent:@"icom.plist"];
    self.dic = [NSDictionary dictionaryWithContentsOfFile:_lastpath];
    
    
    self.myDataArray = [NSMutableArray arrayWithObjects:@"我们的愿望",@"叫ta起床",@"通知",@"设置", nil];
    self.myDataArray1 = [NSMutableArray arrayWithObjects:@"033010",@"033011",@"0335",@"033014", nil];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -50, WIDTH_MY, HEIGHT_MY)style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.view addSubview:self.tableView];
    
    self.bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg1.jpg"]];
    
    self.bgImageView.frame = CGRectMake(0, -50, WIDTH_MY,250);

    [self.tableView addSubview:self.bgImageView];
    
    self.tableView.tableHeaderView = self.bgImageView;
    

    self.icompic1 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2-35, 50+50-10, 70, 70)];
    self.icompic1.layer.cornerRadius =  35;
    self.icompic1.layer.masksToBounds = YES;
    self.icompic1.backgroundColor = [UIColor blackColor];
    [self.bgImageView addSubview:_icompic1];
    
    
    // 头像
   [IcomNSObject icomchange:^(NSDictionary *icomdic) {
       if (icomdic != nil) {
           NSArray *arr = [icomdic objectForKey:@"data"];
           NSString *str10 = [arr[10] objectForKey:@"user_icomalpha"];
           NSLog(@"%@",str10);
           int k = [str10 intValue];
           self.icompic.alpha = k*0.1;
       }
   }];
    self.icompic = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY/2-35, 50+50-10, 70, 70)];
    self.icompic.layer.cornerRadius =  35;
    self.icompic.layer.masksToBounds = YES;
    self.icompic.image = [UIImage imageNamed:@"icom1"];
    [self.bgImageView addSubview:_icompic];
    
    // 名字
    self.namelab = [[UILabel alloc]initWithFrame:CGRectMake(70, 70+40+50+5, WIDTH_MY-140, 30)];
    self.namelab.textAlignment = NSTextAlignmentCenter;
    self.namelab.font = [UIFont systemFontOfSize:15];
    self.namelab.text = @"名字";
    [self.bgImageView addSubview:_namelab];
    
    // 左边按钮
    self.bgImageView.userInteractionEnabled = YES;
    self.leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 110+30+50, (WIDTH_MY-60-90)/2, 30)];
    self.leftbtn.backgroundColor = COLOR(236, 86, 100, 1);
    if (self.dic == nil) {
        [self.leftbtn setTitle:@"ta是天使+1" forState:(UIControlStateNormal)];
    }else{
        NSString *icomleft = [self.dic objectForKey:@"icomleft"];
        [self.leftbtn setTitle:icomleft forState:(UIControlStateNormal)];
    }
     self.leftbtn.titleLabel.font = [UIFont systemFontOfSize:15];
     self.leftbtn.layer.cornerRadius = 5;
    [self.leftbtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:_leftbtn];
    
    
    // 右边按钮
    self.rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(30+90+(WIDTH_MY-60-90)/2, 110+30+50, (WIDTH_MY-60-90)/2, 30)];
    if (self.dic == nil) {
        [self.rightbtn setTitle:@"ta是恶魔+1" forState:(UIControlStateNormal)];
    }else{
        NSString *icomright = [self.dic objectForKey:@"icomright"];
        [self.rightbtn setTitle:icomright forState:(UIControlStateNormal)];
    }
    self.rightbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.rightbtn.backgroundColor = COLOR(236, 86, 100, 1);
    self.rightbtn.layer.cornerRadius = 5;
    [self.rightbtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:_rightbtn];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        WishViewController *wish = [[WishViewController alloc]init];
        wish.hidesBottomBarWhenPushed = YES;
//        [self presentViewController:[[WishViewController alloc]init] animated:YES completion:nil];
        [self.navigationController pushViewController:wish animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }else{
        return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
  
        return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"MyCellIndifer";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [self.myDataArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:[self.myDataArray1 objectAtIndex:indexPath.row]];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _myDataArray[3];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.imageView.image = [UIImage imageNamed:[self.myDataArray1 objectAtIndex:3]];
    }
    
    return cell;
    
}



- (void)left:(UIButton *)sender{
    
    NSLog( @"点击按钮");
    
    if (self.i < 10) {
        self.i++;
        self.j = 0;
        NSString *i = [NSString stringWithFormat:@"ta是天使+%d",_i];
        [self.rightbtn setTitle:@"ta是恶魔+1" forState:(UIControlStateNormal)];
        [self.leftbtn setTitle:i forState:(UIControlStateNormal)];
        
        if (self.dic == nil) {
            self.mutdic = [[NSMutableDictionary alloc]init];
        }else{
            self.mutdic = [NSMutableDictionary dictionaryWithContentsOfFile:_lastpath];
        }
        [self.mutdic setObject:i forKey:@"icomleft"];
        [self.mutdic setObject:@"ta是恶魔+1" forKey:@"icomright"];
        
        
        BOOL isadd =  [self.mutdic writeToFile:_lastpath atomically:YES];
        
        if (isadd) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
        
        NSLog(@"%@",_lastpath);
        
        
        NSString *stricom = [NSString stringWithFormat:@"%d",_i];
        NSDictionary *dd = [[NSDictionary alloc]init];
        
//        [dd setValue:stricom forKey:@"icom"];
        dd = @{@"nicom":stricom,
               @"id":@1};
        [IcomNSObject click:dd Andicomchange:^(NSDictionary *icomdic) {
            NSLog(@"插入成功");
        }];

    }
}

- (void)right:(UIButton *)sender{
    
    NSLog( @"点击按钮");
    
    if (self.j < 10) {
        self.j++;
        self.i = 0;
         NSString *j = [NSString stringWithFormat:@"ta是恶魔+%d",_j];
        [self.leftbtn setTitle:@"ta是天使+1" forState:(UIControlStateNormal)];
        [self.rightbtn setTitle:j forState:(UIControlStateNormal)];
        
        if (self.dic == nil) {
            self.mutdic = [[NSMutableDictionary alloc]init];
        }else{
            self.mutdic = [NSMutableDictionary dictionaryWithContentsOfFile:_lastpath];
        }
        [self.mutdic setObject:j forKey:@"icomright"];
        [self.mutdic setObject:@"ta是天使+1" forKey:@"icomleft"];
        
        BOOL isadd =  [self.mutdic writeToFile:_lastpath atomically:YES];
        
        if (isadd) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
        NSLog(@"%@",_lastpath);
        
        NSString *stricom = [NSString stringWithFormat:@"%d",_j];
        
//        [dd setValue:stricom forKey:@"oicom"];

        NSDictionary *dd = [[NSDictionary alloc]init];
        dd = @{@"nicom":stricom,
               @"id":@1};
        
        [IcomNSObject click:dd Andicomchange:^(NSDictionary *icomdic) {
            NSLog(@"插入成功");
        }];
    }
}




@end
