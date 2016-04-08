//
//  addwishViewController.m
//  dropLove
//
//  Created by administrator on 16/4/7.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "addwishViewController.h"
#import "dropHeader.h"

@interface addwishViewController ()<UITextViewDelegate>

@property (strong, nonatomic)UIView *view1;

@property (strong, nonatomic)UILabel *lable1;

@property (strong, nonatomic)UIView *view2;

@property (strong, nonatomic)UIImageView *image1;

@property (strong, nonatomic)UITextView *textView;

@property (strong, nonatomic)UIButton *addbtn;
@end

@implementation addwishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(243, 239, 230, 1);
    
    //  顶部导航栏
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 25)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, WIDTH_MY-160, 44)];
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = FONT(20);
    titlelab.text = @"添加愿望";
    titlelab.textColor = [UIColor whiteColor];
    [headerView addSubview:titlelab];
    
    self.addbtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH_MY-49, 10, 40, 25)];

//    [self.addbtn setTintColor:[UIColor whiteColor]];
    [self.addbtn addTarget:self action:@selector(addwish) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview: self.addbtn];
    
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_MY, (WIDTH_MY-30-10)/3+200+40-50-50)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view1];
    
    
    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    self.image1.image = [UIImage imageNamed:@"101.jpg"];
    [self.view1 addSubview:_image1];
    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, (WIDTH_MY-30-10)/3+200+40+64+10-50-50, WIDTH_MY, 40)];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 20)];
    lable3.font = FONT(13);
    lable3.text = @"地点";
    lable3.textColor = [UIColor blackColor];
    [self.view2 addSubview:lable3];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY-25, 10, 20, 20)];
    image2.image = [UIImage imageNamed:@"下一页"];
    [self.view2 addSubview:image2];
    
    //  编辑愿望内容
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 5, WIDTH_MY-30, 100)]; //初始化大小
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",dateString);
    
  
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addwish{
    
    NSLog(@"添加完成");

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",dateString);
    
    
    NSString *place = @"上海虹桥";
    
    NSString *str = self.textView.text;
    
    NSMutableDictionary *mutdic1 = [[NSMutableDictionary alloc]initWithCapacity:0];
    int k = 1;
    NSString *kk = [NSString stringWithFormat:@"%d",k];
    [mutdic1 setValue:str forKey:@"content"];
    [mutdic1 setValue:place forKey:@"place"];
    [mutdic1 setValue:dateString forKey:@"date"];
    [mutdic1 setObject:kk forKey:@"id"];
    
    WishViewController *vc = [[WishViewController alloc]init];
    vc.mutDic = mutdic1;
    
    [IcomNSObject addwish:mutdic1 Andaddwish:^(NSDictionary *dic) {
        NSLog(@"添加成功");
    }];
    

    [self dismissViewControllerAnimated:YES completion:nil];


}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [self.lable1 setHidden:NO];
        [self.addbtn setHidden:YES];

    }else{
        [self.lable1 setHidden:YES];
        [self.addbtn setHidden:NO];
        [self.addbtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.addbtn setTintColor:[UIColor whiteColor]];
    }
}


@end
