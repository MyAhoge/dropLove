//
//  commentViewController.m
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "commentViewController.h"
#import "dropHeader.h"
@implementation commentViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_MINE;
    self.sourceArr = [NSMutableArray arrayWithCapacity:0];

    [self headerMethod];
    [self mytable];
    
    [self commentMethod];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentcell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentcellid"];
    if (cell == nil) {
        cell = [[commentcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentcellid"];
    }
    [cell setHeight:_sourceArr[indexPath.row]];
    self.headHeight = cell.frame.size.height;
 
    cell.contentLabel.text = _sourceArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _headHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArr.count;
}
#pragma mark 顶部导航
- (void)headerMethod{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12.5, 10, 20)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackMethod) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 返回按钮
- (void)BackMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark table
- (void)mytable{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _headHeight)];
    self.table.tableHeaderView = headView;
    
    self.dateLab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,40, 20)];
    
    self.dateLab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, _dateLab1.frame.size.height+_dateLab1.frame.origin.y,50, 20)];
    self.dateLab2.font = FONT(10);
    
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 10,WIDTH-70-10, _headHeight-60)];
    [self.contentLab setNumberOfLines:0];
    self.contentLab.font = FONT(13);
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(_contentLab.frame.origin.x, _contentLab.frame.origin.y+_contentLab.frame.size.height, 60, 20)];
    self.timeLab.font = FONT(13);
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-25, _timeLab.frame.origin.y, 25, 20)];
    
    
    [headView addSubview:_dateLab1];
    [headView addSubview:_dateLab2];
    [headView addSubview:_contentLab];
    [headView addSubview:_timeLab];
    [headView addSubview:commentBtn];
    
    self.dateLab1.text = _dateStr1;
    self.dateLab2.text = _dateStr2;
    self.contentLab.text = _contentStr;
    self.timeLab.text = _timeStr;
    
    [commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentMethod) forControlEvents:UIControlEventTouchUpInside];
   
}

#pragma mark 输入框
- (void)commentMethod{
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 40)];
    [self.view addSubview:_footView];
    self.footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-10-50, 30)];
    [self.footView addSubview:_textView];
    //    self.textView.backgroundColor = MICOLOR;
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-30-10, 5, 30, 30)];
    [self.footView addSubview:sendBtn];
    sendBtn.titleLabel.font = FONT(15);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendContentMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView.delegate = self;
}
#pragma mark 点击发送
-(void)sendContentMethod{
    if ([_textView.text isEqualToString:@""]) {
        UILabel *alertlab = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-150)/2, (HEIGHT-50)/2, 150, 50)];
        alertlab.text = @"您还没有输入评论呢，请输入评论吧";
        [self.view addSubview:alertlab];
        
        [UIView animateWithDuration:2 animations:^{
            alertlab.alpha = 0;
        }];
    }else{
        [self.sourceArr addObject:_textView.text];
        [self.table reloadData];
        self.textView.text = nil;
        [self.textView resignFirstResponder];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    CGFloat offSet= self.view.frame.size.height- (_textView.frame.origin.y+_textView.frame.size.height+216+50);
    if (offSet >= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.footView.frame;
            frame.origin.y = offSet;
            self.footView.frame = frame;
        }];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.footView.frame;
        frame.origin.y = HEIGHT-40;
        self.footView.frame = frame;
    }];
    return YES;
}
//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
