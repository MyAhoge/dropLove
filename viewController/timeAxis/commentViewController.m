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
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 25)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackMethod) forControlEvents:UIControlEventTouchUpInside];
}
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
    
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 10,WIDTH-70-10, _headHeight-40)];
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
    [commentBtn addTarget:self action:@selector(import) forControlEvents:UIControlEventTouchUpInside];
   
}
- (void)import{
    //提示框评论
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评论" message:@"请输入您的评论" preferredStyle:UIAlertControllerStyleAlert];
    //输入评论
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"您想说点什么呢？";
    }];
    
    //点击添加
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sourceArr addObject:alert.textFields[0].text];
        [self.table reloadData];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
