//
//  WishViewController.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WishViewController.h"
#import "dropHeader.h"


@interface WishViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>



@property (strong, nonatomic)NSArray *arrwish;

@property (strong, nonatomic)NSMutableArray *mutarrwish;

@property (assign, nonatomic)int k;

@property (copy, nonatomic) NSString *localpath;

@property (copy, nonatomic) NSString *lastpath;

@property (strong, nonatomic) NSDictionary *dic;

@property (strong, nonatomic)NSMutableDictionary *mutdic;

@property (strong, nonatomic)UIView *addview;

@property (strong, nonatomic)UIView *view1;

@property (strong, nonatomic)UIView *view2;

@property (strong, nonatomic)UITextView *textView;

@property (strong, nonatomic)UILabel *lable1;

@property (strong, nonatomic)UIImageView *image1;

@end

@implementation WishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutarrwish = [[NSMutableArray alloc]initWithCapacity:0];
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
    
    
    self.addview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY)];
    self.addview.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view addSubview:_addview];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.addview addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.addview addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, WIDTH-100, 44)];
    lab2.text = @"添加愿望";
    lab2.font = FONT(17);
    lab2.textColor = [UIColor whiteColor];
    lab2.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:lab2];
    
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
    [saveBtn setTitle:@"完成" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];


    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_MY, (WIDTH_MY-30-10)/3+200+40-50-50-10)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.addview addSubview:_view1];
    
    
    //  编辑愿望内容
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(15, 5, WIDTH_MY-30, 100)]; //初始化大小
    self.textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.textView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    self.textView.delegate = self;//设置它的委托方法
    self.textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textView.scrollEnabled = YES;//是否可以拖动
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view1 addSubview: self.textView];//加入到整个页面中
    
    //  提示文字
    self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 13, 120, 15)];
    self.lable1.textColor = [UIColor grayColor];
    self.lable1.font = FONT(15);
    self.lable1.text = @"记录一下愿望吧...";
    self.lable1.textAlignment = NSTextAlignmentLeft;
    [self.view1 addSubview:_lable1];

    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    self.image1.image = [UIImage imageNamed:@"101.jpg"];
    [self.view1 addSubview:_image1];

    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0,(WIDTH_MY-30-10)/3+200+40-50-50-10+64+10 , WIDTH_MY, 40)];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.addview addSubview:_view2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 20)];
    lable3.font = FONT(13);
    lable3.text = @"地点";
    lable3.textColor = [UIColor blackColor];
    [self.view2 addSubview:lable3];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY-25-5, 12.5, 20, 15)];
    image2.image = [UIImage imageNamed:@"下一页"];
    [self.view2 addSubview:image2];
    
    
    [self downline];
}



- (void)downline{
    // CGD 线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [IcomNSObject wish:^(NSDictionary *wishdic) {
//            NSLog(@"%@",wishdic);
            self.arrwish  = [wishdic objectForKey:@"data"];
            self.k = (int)self.arrwish.count;
            NSLog(@"%d",_k);
//            [self.table reloadData];
            
            for (NSDictionary *date1 in self.arrwish) {
                
                ClockModel *model = [[ClockModel alloc]init];
                NSLog(@"%@",[date1 objectForKey:@"wish_content"]);
                model.content = [date1 objectForKey:@"wish_content"];
                model.date = [date1 objectForKey:@"wish_date"];
                model.place = [date1 objectForKey:@"wish_place"];
                model.image = [date1 objectForKey:@"wish_image"];
                [self.mutarrwish addObject:model];
//                NSLog(@"****模型字典****%@",_mutarrwish);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
            
        }];
    });

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"++++组数++++%lu",(unsigned long)self.arrwish.count);
    return self.mutarrwish.count;
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

    
    ClockModel *model = [[ClockModel alloc]init];
    model = self.mutarrwish[self.mutarrwish.count-1-indexPath.section];
    cell.contentlab.text = model.content;
    cell.datelab.text = model.date;
    cell.placelab.text = model.place;
    NSString *image1 = model.image;
    if (image1 != nil) {
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
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.table setHidden:NO];
        self.addview.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }];
    
    NSLog(@"添加愿望");
    
    
}

- (void)cancle{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.table setHidden:NO];
        self.addview.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        [self.navigationController setNavigationBarHidden:NO animated:YES];
         [self.view endEditing:YES];
    }];
    
}


- (void)save{
    
    NSLog(@"发布东西");
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([_textView.text length] == 0) {
            
            UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入内容" preferredStyle:UIAlertControllerStyleAlert];
            [alertctl addAction:alert];
            [self presentViewController:alertctl animated:YES completion:nil];
            
            NSLog(@"请输入内容");
            
            
        }else{
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateStyle:NSDateFormatterFullStyle];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"++++添加时候的时间+++%@",dateString);
            
            
            NSString *place = @"上海虹桥";
            
            NSString *str = self.textView.text;
            
            NSMutableDictionary *mutdic1 = [[NSMutableDictionary alloc]initWithCapacity:0];
            int k = 1;
            NSString *kk = [NSString stringWithFormat:@"%d",k];
            [mutdic1 setValue:str forKey:@"content"];
            [mutdic1 setValue:place forKey:@"place"];
            [mutdic1 setValue:dateString forKey:@"date"];
            [mutdic1 setObject:kk forKey:@"id"];
            
            ClockModel *model = [[ClockModel alloc]init];
            model.content = str;
            model.date = dateString;
            model.place = place;
            model.image = kk;
            [self.mutarrwish addObject:model];
            [self.table reloadData];
            
            [IcomNSObject addwish:mutdic1 Andaddwish:^(NSDictionary *dic) {
                NSLog(@"++++++添加成功");
            }];
            
            [self.table setHidden:NO];
            self.addview.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            
        }
        
        [self.view endEditing:YES];
        
    }];


}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [self.lable1 setHidden:NO];
        
        
    }else{
        [self.lable1 setHidden:YES];
        
    }
}

@end
