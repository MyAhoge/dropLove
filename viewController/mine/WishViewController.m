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
    
     self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    self.title = @"我们的愿望";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //1.创建UIBarButtonItem对象
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addwish)];
    
    //2.把UIBarButtonItem对象赋值给leftBarButtonItem或者rightBarButtonItem
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;

    

   
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY-64) style:UITableViewStyleGrouped];
    
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
    cell.contentlab.text = @"12233";
    cell.contentlab.text = [self.arrwish[(self.arrwish.count-1-indexPath.section)] objectForKey:@"wish_content"];
    cell.datelab.text = [self.arrwish[(self.arrwish.count-1-indexPath.section)] objectForKey:@"wish_date"];
    cell.placelab.text = [self.arrwish[(self.arrwish.count-1-indexPath.section)] objectForKey:@"wish_place"];
    NSString *image = [self.arrwish[(self.arrwish.count-1-indexPath.section)] objectForKey:@"wish_image"];
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



//  添加愿望
- (void)addwish{
    
    addwishViewController *wish1 = [[addwishViewController alloc]init];
    wish1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wish1 animated:YES];

    
}


@end
