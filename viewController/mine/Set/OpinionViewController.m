//
//  OpinionViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/4/13.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "OpinionViewController.h"
#import "dropHeader.h"

@interface OpinionViewController ()

@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.messageLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, WIDTH-30, 20)];
    self.messageLab.text = @"您有什么问题或建议想对我们说？";
    
    self.messageLab.textAlignment = NSTextAlignmentLeft;
    
    self.messageLab.textColor = COLOR_MINE;
    
    self.messageLab.font = FONT(13);
    
    [self.view addSubview:self.messageLab];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 50, WIDTH-30, 160)];
    self.textView.layer.borderColor = COLOR(164, 164, 172, 1).CGColor;
   
    self.textView.layer.borderWidth = 1.0;
    
    self.textView.layer.cornerRadius = 5.0;
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.textView.font = FONT(13);
    
    self.textView.hidden = NO;
    
    self.textView.delegate = self;
    
    [self.view addSubview:self.textView];
    
    self.placeholderLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, WIDTH-30, 20)];
    
    self.placeholderLab.font = FONT(13);
    
    self.placeholderLab.text = @"您的宝贵意见，就是我们进步的源泉";
    
    self.placeholderLab.enabled = NO;//lable必须设置为不可用
    
    self.placeholderLab.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.placeholderLab];
    

    self.descriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 216, WIDTH-30, 50)];
    self.descriptionLab.text = @"^_^请详细描述您遇到的问题，有助于我们快速定位并解决问题，或者留下您宝贵的建议或意见，我们会认真进行评估！";
    
    self.descriptionLab.textColor = COLOR(164, 164, 172, 1);
    
    self.descriptionLab.font = FONT(12);
    
    self.descriptionLab.numberOfLines = 3;
    
    [self.view addSubview:self.descriptionLab];
    
   
    
    self.commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 281, WIDTH-30, 40)];
    
    self.commitBtn.backgroundColor = COLOR_LOGINBTN;
    
    [self.commitBtn setTitle:@"问题提交" forState:UIControlStateNormal ];
    
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitBtn.layer.cornerRadius = 5;
    
    self.commitBtn.layer.masksToBounds = YES;
    
    [self.commitBtn addTarget:self action:@selector(overcommit) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:self.commitBtn];
    
    
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholderLab.text = @"您的宝贵意见，就是我们进步的源泉";
    }else{
        self.placeholderLab.text = @"";
    }
}

#pragma mark - UITextView Delegate Methods
//return回收键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)overcommit{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击空白回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        
        [self.view endEditing:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
