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

@property (strong, nonatomic)UIBarButtonItem *rightbtn;

@end

@implementation addwishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(243, 239, 230, 1);
    
    self.title = @"添加愿望";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    

    self.rightbtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(addwish)];
     self.navigationItem.rightBarButtonItem = _rightbtn;

    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    

    
    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, (WIDTH_MY-30-10)/3+200+40-50-50-10)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view1];
    
    
    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    self.image1.image = [UIImage imageNamed:@"101.jpg"];
    [self.view1 addSubview:_image1];
    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, (WIDTH_MY-30-10)/3+200+40+64+10-50-50-64-10, WIDTH_MY, 40)];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 20)];
    lable3.font = FONT(13);
    lable3.text = @"地点";
    lable3.textColor = [UIColor blackColor];
    [self.view2 addSubview:lable3];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY-25-5, 12.5, 20, 15)];
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
    self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(17, 13, 120, 15)];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addwish{
    
    
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
            NSLog(@"++++++添加成功");
        }];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        }




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
