//
//  ClockViewController.m
//  dropLove
//
//  Created by administrator on 16/4/8.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "ClockViewController.h"
#import "dropHeader.h"
#import <AVFoundation/AVFoundation.h>


@interface ClockViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic)UITableView *table;

@property (strong, nonatomic)UIView *view1;

@property (strong, nonatomic)UIView *view2;

@property (strong, nonatomic)UIDatePicker *picker;

@property (strong, nonatomic)UILabel *datelable;

@property (strong, nonatomic)NSMutableArray *mutArr;

@property (strong, nonatomic)NSMutableArray *mutArr1;

@property (copy, nonatomic)NSString *timestr;

@property (copy, nonatomic)NSString *gettime;

@property (assign, nonatomic)int i;

@property (assign, nonatomic)int j;

@property (strong, nonatomic)NSArray *clockcount;


@property (strong, nonatomic)AVAudioPlayer *myplayer;

@property (strong, nonatomic)UIButton *stopclock;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     初始化一些东西
     */
    self.mutArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.mutArr1 = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = COLOR(243, 239, 230, 1);
    self.i = 0;
    self.j = 0;
    
    
    /**
     *  顶部导航
     */
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"定时提醒";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addclock)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    /**
     设置table
     */
    self.table  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY)];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = COLOR(243, 239, 230, 1);
    self.table.separatorColor = [UIColor grayColor];
    self.table.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_table];
    
    
    
    /**
     添加定时提醒时间顶部栏
     */
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY)];
    self.view1.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view addSubview:_view1];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view1 addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view1 addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, WIDTH-100, 44)];
    lab2.text = @"定时提醒";
    lab2.font = FONT(17);
    lab2.textColor = [UIColor whiteColor];
    lab2.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:lab2];
    
    
    /**
     取消添加起床闹钟界面按钮
     */
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 30, 44)];
    [headerView addSubview:backBtn];
    backBtn.titleLabel.font = FONT(15);
    backBtn.titleLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     存储添加起床闹钟按钮
     */
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-24-20, 0, 30, 44)];
    [headerView addSubview:saveBtn];
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    saveBtn.titleLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
    saveBtn.titleLabel.font = FONT(15);
    [saveBtn setTitle:@"存储" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    /**
     时间选择器
     */
    self.picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, WIDTH_MY, 216)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.datePickerMode =  UIDatePickerModeTime;
    [self.picker addTarget:self action:@selector(seledate) forControlEvents:UIControlEventValueChanged];
    [self.view1 addSubview:self.picker];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.picker.locale = locale;
    
    /**
     选中的时间显示在单独的label上
     */
    self.datelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, WIDTH_MY, 50)];
    self.datelable.font = [UIFont systemFontOfSize:25];
    self.datelable.textAlignment = NSTextAlignmentCenter;
    self.datelable.textColor = [UIColor grayColor];
    [self.view1 addSubview:_datelable];
    
    
    /**
     *  读取模型数据（起床闹钟）
     */
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    self.clockcount = [defaults1 objectForKey:@"time5"];//根据键值取出name
    if (self.clockcount == nil) {
        self.i = 0;
    }else{
        NSLog(@"%lu",(unsigned long)self.clockcount.count);
         self.i = (int)self.clockcount.count;
    }
   
    NSLog(@" 一共有个闹钟 %d",_i);
    NSLog(@"-------%@",self.mutArr1);
    for (NSString *time2 in self.clockcount) {
        ClockModel *model = [[ClockModel alloc]init];
        model.time = time2;
        self.gettime = time2;
        NSLog(@"进入时取出的闹钟时间%@",time2);
        [self.mutArr1 addObject:model];
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(creat) userInfo:nil repeats:YES];
    [timer fire];
    
   
    /**
     闹钟停止按钮
     */
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_MY, WIDTH_MY, 200)];
    self.view2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_view2];
    self.stopclock = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, WIDTH_MY-100, 100)];
    self.stopclock.layer.cornerRadius = 5;
    self.stopclock.backgroundColor = [UIColor grayColor];
    [self.stopclock setTintColor:[UIColor whiteColor]];
    [self.stopclock setTitle:@"停止闹铃" forState:UIControlStateNormal];
    [self.stopclock addTarget:self action:@selector(stop) forControlEvents: UIControlEventTouchUpInside];
    self.stopclock.titleLabel.font = FONT(30);
    self.stopclock.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.stopclock.titleLabel.textAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view2 addSubview:_stopclock];
 
    
}


/**
 *  创建起床闹钟
 */
- (void)creat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"输出本地时间:%@",dateString);
    int hour = [[dateString substringToIndex:2]intValue];
//    NSLog(@"%d",hour);
    int minute = [[dateString substringWithRange:NSMakeRange(3,2)]intValue];
//    NSLog(@"%d",minute);
    int second = [[dateString substringFromIndex:6] intValue];
//    NSLog(@"%d",second);
    
    int huor1 = [[self.clockcount[_j] substringToIndex:2]intValue];
    int minute1 = [[self.clockcount[_j] substringFromIndex:3]intValue];
//    NSLog(@"%d  +  %d",huor1,_j);
//    NSLog(@"%d",minute1);
//    
    if (hour >= huor1 && minute > minute1) {
        if (self.j < _i-1) {
            self.j++;
            NSLog(@"%d",_j);
        }
    }
    
    if (hour == huor1 && minute == minute1 && second == 0) {
        NSLog(@"闹钟响起");
        
        /**
         *  闹钟音乐
         */
        if (![self.myplayer isPlaying]) {
            
            [self.myplayer play];
        }
        
        if (self.j < _i-1) {
            self.j++;
            
        }
        
        /**
         *  跳出闹钟响起关闭界面
         */
        [self.table setHidden:YES];
        self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0,100, WIDTH_MY, 200)];
        [self.view addSubview:_view2];
        [self.view2 addSubview:_stopclock];
    }
    
}

- (void)stop{
    
    [self.myplayer stop];
    [self.view2 setHidden:YES];
    [self.table setHidden:NO];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mutArr1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



/**
 *  cell内容
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.font = FONT(35);
    ClockModel *model = [[ClockModel alloc]init];
    model = _mutArr1[indexPath.row];
    cell.textLabel.text = model.time;
    UISwitch *switch1 = [[UISwitch alloc]init];
    switch1.on = YES;
    [switch1 addTarget:self action:@selector(switchon) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = switch1;
    
    
    return cell;
    
}

- (void)switchon{
    
    NSLog(@"开关转态");
    
}



/**
 *  右侧滑动删除
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.mutArr1 removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationLeft];
    
}



- (void)save{
    
    /**
     添加闹钟写入模型
     */
    ClockModel *model = [[ClockModel alloc]init];
    model.time = self.timestr;
    [self.mutArr1 addObject:model];
    NSLog(@"模型*****%@",self.mutArr1);
    [self.table reloadData];
    
    
    
    
    
    
    /**
     *  写入数据
     */
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [self.mutArr addObject:self.timestr];
    [defaults setObject:self.mutArr forKey:@"time5"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    
    /**
     *  读取数据
     */
    NSUserDefaults *defaults1 =[NSUserDefaults standardUserDefaults];
    NSString *name1 = [defaults1 objectForKey:@"time5"];//根据键值取出name
    NSLog(@"读取数据%@",name1);
    
    
    /**
     *  显示提醒闹钟页面
     */
    [UIView animateWithDuration:0.0001 animations:^{
        
        [self.table setHidden:NO];
        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }];
    
}


/**
 *  进入添加闹钟界面
 */
- (void)addclock{
    
    NSLog(@"进入添加闹钟界面");
    [UIView animateWithDuration:0.0001 animations:^{
        
        [self.table setHidden:YES];
        self.view1.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }];
}

/**
 *  取消按钮
 */
- (void)cancle{
    
    [UIView animateWithDuration:0.0001 animations:^{
        
        [self.table setHidden:NO];
        self.view1.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }];
}

/**
 *  日期选择转换格式
 */
- (void)seledate{
    
    //NSDate格式转换为NSString格式
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *pickerDate = [self.picker date];
    // 创建一个日期格式器
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [pickerFormatter setDateFormat:@"HH:mm"];
    self.timestr = [pickerFormatter stringFromDate:pickerDate];
    self.datelable.text = [NSString stringWithFormat:@"设定时间:%@",self.timestr];
    NSLog(@"%@",_timestr);
    
}


/**
 *  建立音乐播放
 */
- (AVAudioPlayer *)myplayer{
    
    if (!_myplayer) {
        
        NSString *strurl = [[NSBundle mainBundle]pathForResource:@"黄致列 - 默" ofType:@"mp3"];
        
        NSURL *url = [NSURL fileURLWithPath:strurl];
        NSError *error = nil;
        
        self.myplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
    }
    return _myplayer;
}



@end
