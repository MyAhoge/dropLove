//
//  WishViewController.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WishViewController.h"
#import "dropHeader.h"


@interface WishViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic)NSArray *arrwish;

@property (assign, nonatomic)int k;


@property (copy, nonatomic) NSString *localpath;

@property (copy, nonatomic) NSString *lastpath;

@property (strong, nonatomic) NSDictionary *dic;

@property (strong, nonatomic)NSMutableDictionary *mutdic;
@end

@implementation WishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
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
      titlelab.font = FONT(20);
    titlelab.textColor = [UIColor whiteColor];
    [headerView addSubview:titlelab];
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH_MY-49, 10, 40, 25)];
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
    
    [self downline];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self downline];
    [self.table reloadData];
}


- (void)downline{
    // CGD 线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [IcomNSObject wish:^(NSDictionary *wishdic) {
            NSLog(@"%@",wishdic);
            self.arrwish  = [wishdic objectForKey:@"data"];
            self.k = (int)self.arrwish.count;
            NSLog(@"%d",_k);
            [self.table reloadData];
            
            // plist
            PlistLocalInfo *localinfo = [[PlistLocalInfo alloc]init];
            self.localpath = [localinfo userInfoPath];
            self.lastpath = [_localpath stringByAppendingPathComponent:@"wish.plist"];
            self.dic = [NSDictionary dictionaryWithContentsOfFile:_lastpath];
            
            
            if (self.dic == nil) {
                self.mutdic = [[NSMutableDictionary alloc]init];
            }else{
                self.mutdic = [NSMutableDictionary dictionaryWithContentsOfFile:_lastpath];
            }
            NSLog(@"%@",_mutdic);
            [self.mutdic setObject:wishdic forKey:@"readwish"];
            NSLog(@"********%@",_mutdic);
            
            BOOL isadd =  [self.mutdic writeToFile:_lastpath atomically:YES];
            
            if (isadd) {
                NSLog(@"添加成功");
            }else{
                NSLog(@"添加失败");
            }
            
            if (isadd) {
                NSLog(@"添加成功");
            }else{
                NSLog(@"添加失败");
            }
            
            NSLog(@"%@",_lastpath);
            
        }];
    });

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"++++组数++++%lu",(unsigned long)self.arrwish.count);
    return self.arrwish.count;
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
    
    cell.contentlab.text = [self.arrwish[(self.arrwish.count-1-indexPath.section)] objectForKey:@"wish_content"];
    cell.datelab.text = [self.arrwish[indexPath.section] objectForKey:@"wish_date"];
    cell.placelab.text = [self.arrwish[indexPath.section] objectForKey:@"wish_place"];
    NSString *image = [self.arrwish[indexPath.section] objectForKey:@"wish_image"];
    if (image != nil) {
        cell.image.image = [UIImage imageNamed:@"丽江.jpg"];
    }
    
    [cell setHeight:cell.contentlab.text];
    self.height = cell.frame.size.height;

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
    [self presentViewController:[[addwishViewController alloc]init] animated:YES completion:nil];
}


@end
