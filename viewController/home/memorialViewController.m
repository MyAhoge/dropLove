//
//  memorialViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "memorialViewController.h"
#import "dropHeader.h"
@interface memorialViewController ()

@end

@implementation memorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = COLOR(239, 239, 243,1);

    
    [self dataSource];
    
    self.navigationItem.title = @"纪念日";
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:19 weight:8]
                                                                    
                                                                    };
    
    //1.创建UIBarButtonItem对象
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addmemorial:)];
    
    //2.把UIBarButtonItem对象赋值给leftBarButtonItem或者rightBarButtonItem
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;

    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    
    self.table.backgroundColor = COLOR(243,239,230,1);
    
    self.table.delegate = self;
    
    self.table.dataSource = self;
    
    self.table.showsVerticalScrollIndicator = NO;
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.sectionHeaderHeight = 5;
    
    self.table.sectionFooterHeight = 5;

    
    [self.view addSubview:self.table];
    
    //headview内容
    
    self.myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 70)];
    
    self.table.tableHeaderView = self.myview;
    
    self.myview.backgroundColor = [UIColor whiteColor];
    
    [self.table addSubview:self.myview];
    
//    self.firstline = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, WIDTH, 10)];
//    
//    self.firstline.backgroundColor = COLOR(243, 239, 230, 1);
//    
//    [self.myview addSubview:self.firstline];
//    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 32, 32)];
    
    self.image.image = [UIImage imageNamed:@"memoriallove.png"];
    
    [self.myview addSubview:self.image];
    
    self.weloveLab = [[UILabel alloc]initWithFrame:CGRectMake(53, 15, 91, 21)];
    
    self.weloveLab.text = @"我们相爱已经";
    
    self.weloveLab.font = FONT(15);
    
    self.weloveLab.textColor =[UIColor blackColor];
    
    [self.myview addSubview:self.weloveLab];
    
    self.lovedateLab = [[UILabel alloc]initWithFrame:CGRectMake(53, 35, 102, 14)];
    
    self.lovedateLab.text = @"距2015年12月22日";
    
    self.lovedateLab.font = FONT(10);
    
    self.lovedateLab.textColor = COLOR(167, 167, 172, 1);
    
    [self.myview addSubview:self.lovedateLab];
    
    self.alldateLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100, 15, 70, 24)];
    
    self.alldateLab.text = @"1000";
    
    self.alldateLab.font = FONT(28);
    
    self.alldateLab.textColor = COLOR(46, 204, 255, 1);
    
    [self.myview addSubview:self.alldateLab];

    self.dayLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-25, 21, 15, 21)];
    
    self.dayLab.textColor = [UIColor blackColor];
    
    self.dayLab.text = @"天";
    
    self.dayLab.font = FONT(15);
    
    [self.myview addSubview:self.dayLab];
    
    self.tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapmyview)];
    
    [self.myview addGestureRecognizer:self.tapGesturRecognizer];
    
    
    
    
    
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    memorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell ==nil) {
        cell = [[memorialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    //无色
    memorialDayModel *me = [[memorialDayModel alloc]init];
    me = self.Arr[indexPath.row];
    
    [dataService addWith:^(NSDictionary *dic) {
        self.Arr = [dic objectForKey:@"result"];
        cell.detailLab.text = [self.Arr[indexPath.section]objectForKey:@"memday_content"];
        NSLog(@"%@",[self.Arr[indexPath.section]objectForKey:@"memday_content"]);
        
        cell.yearLab.text = [[self.Arr[indexPath.section]objectForKey:@"memday_date"] substringToIndex:7];
        
        cell.dayLab.text = [[self.Arr[indexPath.section]objectForKey:@"memday_date"] substringFromIndex:8];
//        cell.detailLab.text = contentstr;
    }];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    
    cell.tianLab.text = @"天";
    
    cell.numLab.text = @"300";
    
//    cell.yearLab.text = @"2000";
//    
//    cell.mouthLab.text = @"08";
//    
//    cell.dayLab.text = @"22";

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.Arr removeObjectAtIndex:indexPath.section];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addmemorial:(UIButton *)sender{
    addMemorialDayViewController *addMem = [[addMemorialDayViewController alloc]init];
    addMem.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addMem animated:YES];
}

-(void)tapmyview{

    ShareViewController *share = [[ShareViewController alloc]init];
    
    //隐藏底部tabbar
    share.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:share animated:YES];
}
#pragma mark 数据处理
- (void)dataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
        
        
//       [ dataService  socialAddWidth:^(NSDictionary *resultDic) {
//           NSLog(@"121122112");
//       } addWidth:^(NSDictionary *error) {
//           
//       }];
//        NSDictionary *dic;
//        [dataService addWith:^(NSDictionary *dic) {
//            self.Arr = [dic objectForKey:@"result"];
//            NSString *contentstr = [self.Arr[0] objectForKey:@"memday_content"];
//            NSString *datestr = [self.Arr[0] objectForKey:@"memday_date"];
//        }];
//        
        
        
//        [dataService timeAxisAddWidth:^(NSDictionary *resultDic) {
//            self.dic = [[NSDictionary alloc]initWithDictionary:resultDic];
//            
//            NSArray *arr = [_dic objectForKey:@"result"];
//            self.contentArr = [NSMutableArray arrayWithCapacity:0];
//            self.timeArr = [NSMutableArray arrayWithCapacity:0];
//            self.dateArr = [NSMutableArray arrayWithCapacity:0];
//            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
//            
//            for (NSDictionary *dic in arr) {
//                timeaxisModel *model = [[timeaxisModel alloc]init];
//                
//                model.content = [dic objectForKey:@"timeaxis_content"];
//                model.time = [dic objectForKey:@"timeaxis_time"];
//                model.date = [dic objectForKey:@"timeaxis_date"];
//                [self.sourceArr addObject:model];
//                
//                //                [self.contentArr addObject:[dic objectForKey:@"timeaxis_content"]];
//                //                [self.timeArr addObject:[dic objectForKey:@"timeaxis_time"]];
//                //                [self.dateArr addObject:[dic objectForKey:@"timeaxis_date"]];
//            }
        
//        } addWidth:^(NSDictionary *error) {
//            NSLog(@"error");
//        }];
    });
}
@end
