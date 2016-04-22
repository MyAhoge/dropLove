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

    
    [self updataTimeAxis];
    
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
    
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *dateString1 = [dateFormatter stringFromDate:currentDate];
    
    NSLog(@"dateString:%@",dateString1);
    
//    self.lovedateLab.text = dateString1;
    
    self.lovedateLab.font = FONT(10);
    
    self.lovedateLab.textColor = COLOR(167, 167, 172, 1);
    
    [self.myview addSubview:self.lovedateLab];
    
    
    
    self.alldateLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-130, 15, 100, 24)];
    
    self.alldateLab.font = FONT(28);
    
    self.alldateLab.textAlignment = NSTextAlignmentRight;
    
    self.alldateLab.textColor = COLOR(46, 204, 255, 1);
    
    [self.myview addSubview:self.alldateLab];

    self.dayLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-25, 21, 15, 21)];
    
    self.dayLab.textColor = [UIColor blackColor];
    
    self.dayLab.text = @"天";
    
    self.dayLab.font = FONT(15);
    
    [self.myview addSubview:self.dayLab];
    
    self.tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapmyview)];
    
    [self.myview addGestureRecognizer:self.tapGesturRecognizer];
   
    /**
     *  读取相爱的日期数据
     */
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    NSString *name1 = [defaults1 objectForKey:@"time"];//根据键值取出name
    NSLog(@"读取数据%@",name1);
   
    self.lovedateLab.text = name1;
    
    [self updataTimeAxis];
}
- (void)updataTimeAxis{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    [refresh addTarget:self action:@selector(dataSource:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refresh];
    [refresh beginRefreshing];
    [self dataSource:refresh];
    
}

//我们相爱时间天数计算

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    NSString *name1 = [defaults1 objectForKey:@"time"];//根据键值取出name
//    NSLog(@"读取数据%@",name1);
    NSDate *localDate = [NSDate date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *date2 = [dateFormatter2 dateFromString:name1];
    
    NSTimeInterval time=[ localDate timeIntervalSinceDate:date2];
    
    int days=((int)time)/(3600*24);
    
    NSString *lovedateContent=[[NSString alloc] initWithFormat:@"%i",days];
    
//    NSLog(@"%i",days);
    
    self.alldateLab.text = lovedateContent;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    memorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell ==nil) {
        cell = [[memorialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    //cell不显示点击状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    memorialDayModel *me = [[memorialDayModel alloc]init];
    me = self.cellArr[indexPath.section];
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSLog(@"dateString:%@",dateString);
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1=[dateFormatter dateFromString:me.date];
    
//    NSLog(@">>>>%@",date1);
    
    NSTimeInterval time=[ currentDate timeIntervalSinceDate:date1];
    
    int days=((int)time)/(3600*24);
   
    self.dateContent=[[NSString alloc] initWithFormat:@"%i",days];
    
//    NSLog(@"%@",dateContent);


    if ([_dateContent isEqualToString:@"0"]) {
        cell.numLab.text = @"今";
        
        cell.detailLab.text =  me.content;
    }else{
        NSString *detailstr = [[NSString alloc]initWithFormat:@"%@已经",me.content];
        cell.detailLab.text = detailstr;
        
        cell.numLab.text = _dateContent;
    }

    cell.yearLab.text = [me.date substringToIndex:7];
    
    cell.dayLab.text =[me.date substringFromIndex:8];
    
    cell.tianLab.text = @"天";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cellArr.count;
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
    
    ShareViewController *share = [[ShareViewController alloc]init];
    memorialDayModel *model = [[memorialDayModel alloc]init];
    model = self.cellArr[indexPath.section];
    
    share.timeStr = model.date;
    share.contentStr = model.content;
    share.dayStr = self.dateContent;
    [self.navigationController pushViewController:share animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.section);

    
    memorialDayModel *model = [[memorialDayModel alloc]init];
    model = _cellArr[indexPath.section];
    
    
    NSDictionary *dic = @{@"memdayid":model.memdayid};
    [dataService memorialDatadelete:dic andWithSucess:^(NSDictionary *result) {
        
    } andWithError:^(NSDictionary *errorDic) {
        
    }];
    
    
    [self.cellArr removeObjectAtIndex:indexPath.section];
    
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]  withRowAnimation:UITableViewRowAnimationRight];

   

    
    
}
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark next
- (void)addmemorial:(UIButton *)sender{
    addMemorialDayViewController *addMem = [[addMemorialDayViewController alloc]init];
    addMem.hidesBottomBarWhenPushed = YES;
    
    addMem.delegate = self;
    
    [self.navigationController pushViewController:addMem animated:YES];
}

-(void)tapmyview{
    
    editMemorialDayViewController *edit = [[editMemorialDayViewController alloc]init];
    
    edit.hidesBottomBarWhenPushed = YES;
    
    edit.delegate = self;
    
    [self.navigationController pushViewController:edit animated:YES];
    
}
#pragma mark 数据处理
- (void)dataSource:(UIRefreshControl *)sender{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *dic = @{@"userid":@1};
        [dataService mmmm:dic addWith:^(NSDictionary *dic) {
            //给一个空间，未分配
            self.cellArr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dd in [dic objectForKey:@"result"]) {
                memorialDayModel *memModel = [[memorialDayModel alloc]init];
                
                memModel.content = [dd objectForKey:@"memday_content"];
                
                memModel.date = [dd objectForKey:@"memday_date"];
                
                memModel.memdayid = [dd objectForKey:@"memday_id"];
                
                [self.cellArr addObject:memModel];
                
                NSLog(@"%@",memModel.content);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
                [sender endRefreshing];
            });
        }];
        
    });
}

-(void)showMemorial:(NSMutableDictionary *)addDic{
    
  
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        memorialDayModel *addModel = [[memorialDayModel alloc]init];
        
        addModel.content = [addDic objectForKey:@"content"];
        
        addModel.date = [addDic objectForKey:@"date"];
        
        [self.cellArr addObject:addModel];
        
        
        [dataService memorialDataAddDic:addDic addWith:^(NSDictionary *resultDic) {
            NSLog(@">>>%@",resultDic);
        } addWith:^(NSDictionary *errorDic) {
            
        }];
        [self updataTimeAxis];
  
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    });
    
    [self.table reloadData];
    
}

-(void)printDate:(NSString *)loveDateString{
    
   
   self.lovedateLab.text = loveDateString;
    
    /**
     *  写入数据
     */
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    NSString *str = 

    [defaults setObject:self.lovedateLab.text forKey:@"time"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    
//    /**
//     *  读取数据
//     */
//    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
//    NSString *name1 = [defaults1 objectForKey:@"time"];//根据键值取出name
//    NSLog(@"读取数据%@",name1);
  
    
    

}


@end
