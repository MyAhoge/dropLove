//
//  editMemorialDayViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "editMemorialDayViewController.h"
#import "dropHeader.h"
@interface editMemorialDayViewController ()

@end

@implementation editMemorialDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = COLOR(243, 239, 230, 1);
    
    self.navigationItem.title = @"编辑纪念日";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                    
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    
                                                                    };
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(overedit:)];
    rightBtn.tintColor = [UIColor whiteColor];
   

    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    self.editView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, WIDTH, 101)];
    
    self.editView.backgroundColor = [UIColor whiteColor];
    
    self.editView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.editView];
    
    self.memLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 46, 21)];
    
    self.memLab.text = @"纪念日";
    
    self.memLab.textColor = [UIColor blackColor];
    
    self.memLab.font = FONT(15);
    
    [self.editView addSubview:self.memLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 68, 46, 21)];
    
    self.timeLab.text = @"时间";
    
    self.timeLab.textColor = [UIColor blackColor];
    
    self.timeLab.font = FONT(15);
    
    [self.editView addSubview:self.timeLab];
    
    
    self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, WIDTH-15, 1)];
    
    self.lineLab.backgroundColor = COLOR(167, 167, 172, 1);
    
    [self.editView addSubview:self.lineLab];
    
    self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, WIDTH-80, 50)];
    //默认文本
    
    self.textLab.text = @"我们已经相爱";
    
    self.textLab.textAlignment = NSTextAlignmentRight;
    
    self.textLab.font = FONT(12);
    
    self.textLab.textColor = COLOR(167, 167, 172, 1);
    
    [self.editView addSubview:self.textLab];
   
 //UIDatePicker
    
    self.i = 0;
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    
    [self.view addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged ];//重点：UIControlEventValueChanged
    
    //    设置语言
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker.locale = locale;
    
    self.showBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 51, WIDTH-80, 50)];
    
    self.showBtn.backgroundColor = [UIColor whiteColor];
    
    self.showBtn.titleLabel.font = FONT(12);

    self.showBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight ;
    
    //获取当前时间，日期
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *dateString1 = [dateFormatter stringFromDate:currentDate];
    
    NSLog(@"dateString:%@",dateString1);
    
    [self.showBtn setTitle:@"选择纪念日时间" forState:UIControlStateNormal];
    
    [self.showBtn setTitleColor:COLOR(14, 134, 252, 1) forState:UIControlStateNormal];
    
    [self.editView addSubview:self.showBtn];
    
    [self.showBtn addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchDown];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)overedit:(UIButton *)sender{
    
    
    if (_dateString.length == 0 ) {
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择时间" preferredStyle:UIAlertControllerStyleAlert];
        [alertctl addAction:alert];
        [self presentViewController:alertctl animated:YES completion:nil];
    }else{
        if (_delegate != nil &&[_delegate respondsToSelector:@selector(printDate:)]) {
            [_delegate printDate:_dateString];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        

    }
    
}
////点击空白处收回键盘
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.textfield resignFirstResponder];
//    
//  
//}
////点击return收回键盘
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self.textfield resignFirstResponder];
//    return YES;
//}
//日期选择器
-(void)showDatePicker{
    self.i = _i +1;
    
    if (_i%2 == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.datePicker.frame = CGRectMake(0, self.view.frame.size.height,  self.view.frame.size.width, 216);
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.datePicker.frame = CGRectMake(0, self.view.frame.size.height-216,  self.view.frame.size.width, 216);
        }];
    }
    
}

-(void)dateChanged{
    
    //NSDate格式转换为NSString格式
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *pickerDate = [self.datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
    self.dateString = [pickerFormatter stringFromDate:pickerDate];
    
  
    NSDate *dateB = [NSDate date];
    NSComparisonResult result = [pickerDate compare:dateB];
    if (result == NSOrderedDescending) {
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"提示" message:@"您选取的时间超出范围" preferredStyle:UIAlertControllerStyleAlert];
        [alertctl addAction:alert];
        [self presentViewController:alertctl animated:YES completion:nil];
    }
    
    [self.showBtn setTitle: _dateString forState:UIControlStateNormal ];
  
}
@end
