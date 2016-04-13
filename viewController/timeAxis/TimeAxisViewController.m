//
//  TimeAxisViewController.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "TimeAxisViewController.h"
#import "dropHeader.h"

@implementation TimeAxisViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:COLOR_MINE];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //TODO:navigationItem选择器
    NSArray *arr = [NSArray arrayWithObjects:@"时光",@"相册", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    self.navigationItem.titleView = segment;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addBtn;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    self.sendDic = [[NSDictionary alloc]init];
    [self dataSource];
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH*2, HEIGHT-49)];
    self.myView.layer.masksToBounds = NO;
    [self.view addSubview:_myView];
    
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _myView.frame.size.height)];
    [self.myView addSubview:_timeView];
    self.picView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, _myView.frame.size.height)];
    [self.myView addSubview:_picView];

    [self myTableView];
}

- (void)segmentAction:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self  timeAxis];
            break;
        case 1:
            [self picAxis];
            break;
        default:
            break;
    }
}
#pragma mark 代理方法，获得返回值
- (void)sendMethod:(NSDictionary *)send{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [dataService addDataDic:send addWith:^(NSDictionary *resultDic) {
            NSLog(@"result%@",resultDic);
            
            [dataService timeaxisSetImg:[send objectForKey:@"imgarr"] andHomeWorkId:12 andSuccess:^(NSString *str) {
                NSLog(@"%@", str);
            } andFail:^(NSString *error) {
                
            }];
            
        } addWith:^(NSDictionary *errorDic) {
            
        }];
        
        timeaxisModel *model = [[timeaxisModel alloc]init];
        
        model.content = [send objectForKey:@"content"];
        model.date = [send objectForKey:@"date"];
        model.time = [send objectForKey:@"time"];
        model.imgArr = [send objectForKey:@"imgarr"];
        [self.sourceArr addObject:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
               [self.table reloadData];
        });
    });
}
#pragma mark tableView
- (void)myTableView{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    [self.timeView addSubview:_table];
    self.table.backgroundColor = MICOLOR;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.picTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    [self.picView addSubview:_picTable];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //
    self.table.delegate = self;
    self.table.dataSource = self;
    
    self.picTable.delegate = self;
    self.picTable.dataSource = self;
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    self.table.tableHeaderView = image;
    image.image = [UIImage imageNamed:@"timebg.jpg"];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    self.picTable.tableHeaderView = image1;
    image1.image = [UIImage imageNamed:@"timebg.jpg"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_table]) {
        return _sourceArr.count;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:_table]) {
        return _height;
    }else{
        return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_table]) {
        timeaxisModel *timeModel = [[timeaxisModel alloc]init];
        timeModel = self.sourceArr[_sourceArr.count - 1 - indexPath.row];
        
        if (timeModel.imgArr.count == 0) {
  
            timelistcell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropLove"];
            if (cell == nil) {
                cell = [[timelistcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dropLove"];
            }
            
            cell.backgroundColor = MICOLOR;
            
            
            
            cell.dateLabel1.text = [timeModel.date substringFromIndex:8];
            cell.dateLabel2.text = [timeModel.date substringToIndex:7];
            cell.timeLabel.text = timeModel.time;
            cell.contentlabel.text = timeModel.content;
            
            cell.heartImage.image = [UIImage imageNamed:@"heart"];
            
            [cell setHeight:timeModel.content];
            self.height = cell.frame.size.height;
            
            [cell.deletebtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//            [cell.deletebtn setTitle:@"删除" forState:UIControlStateNormal];
//            [cell.deletebtn setTitleColor:COLOR(167, 167, 172, 1) forState:UIControlStateNormal];
            cell.deletebtn.tag = _sourceArr.count - 1 - indexPath.row;
            [cell.deletebtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
             return cell;
        }else{
            timeListimagecell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeListimagecellid"];
            if (cell == nil) {
                cell = [[timeListimagecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"timeListimagecellid"];
            }
            cell.backgroundColor = MICOLOR;
            
            cell.dateLabel1.text = [timeModel.date substringFromIndex:8];
            cell.dateLabel2.text = [timeModel.date substringToIndex:7];
            cell.timeLabel.text = timeModel.time;
            cell.contentlabel.text = timeModel.content;
            
            cell.heartImage.image = [UIImage imageNamed:@"heart"];
            
            [cell setHeight:timeModel.content];
            self.height = cell.frame.size.height;
            
            [cell.deletebtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            cell.deletebtn.tag = _sourceArr.count - 1 - indexPath.row;
            [cell.deletebtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
            
            if (timeModel.imgArr.count == 1) {
                cell.image1.image = timeModel.imgArr[0];
            }else if(timeModel.imgArr.count == 2){
                cell.image1.image = timeModel.imgArr[0];
                cell.image2.image = timeModel.imgArr[1];
            }else if (timeModel.imgArr.count == 3){
                cell.image1.image = timeModel.imgArr[0];
                cell.image2.image = timeModel.imgArr[1];
                cell.image3.image = timeModel.imgArr[2];
                
            }else{
                
            }
            return cell;
        }
    }else{
        piclistcell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"piclistid"];
        if (cell2 == nil) {
            cell2 = [[piclistcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"piclistid"];
        }
        cell2.backgroundColor = MICOLOR;
        cell2.dateLabel1.text = @"5月";
        cell2.image1.image = [UIImage imageNamed:@"timebg.jpg"];
        cell2.image2.image = [UIImage imageNamed:@"timebg.jpg"];
        cell2.image3.image = [UIImage imageNamed:@"timebg.jpg"];
        return cell2;
    }
}
#pragma mark 删除功能
- (void)deleteMethod:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除心情之后将无法恢复，确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary *dic = @{@"timeid":(timeaxisModel *)[_sourceArr[sender.tag] timeid]};
        
        [dataService timeaxisDelete:dic andWithSucess:^(NSDictionary *resultDic) {
            [self.sourceArr removeObjectAtIndex:sender.tag];
            [self.table reloadData];
        } andWithError:^(NSDictionary *error) {
            
        }];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:_table]) {
        commentViewController *comment = [[commentViewController alloc]init];
        
        timeaxisModel *model = [[timeaxisModel alloc]init];
        model = self.sourceArr[indexPath.row];
        
        comment.dateStr1 = [model.date substringFromIndex:8];
        comment.dateStr2 = [model.date substringToIndex:7];
        comment.contentStr = model.content;
        comment.timeStr = [model.time substringToIndex:5];
        comment.headHeight = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
        comment.imgArr = model.imgArr;
        //隐藏底部导航
        comment.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comment animated:YES];
//        [self presentViewController:comment animated:YES completion:nil];
    }
}

#pragma mark 时光栏
- (void)timeAxis{
    
    self.myView.frame = CGRectMake(0, 0, WIDTH * 2, HEIGHT-64-49);
//    [self.myView addSubview:_timeView];
//    self.picBtn.layer.borderWidth = 0;
//    self.timeBtn.layer.borderWidth = 1;
//    self.timeBtn.layer.cornerRadius = 5;
//    self.timeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}
#pragma mark 相册栏
- (void)picAxis{

    self.myView.frame = CGRectMake(-WIDTH, 0, WIDTH * 2, HEIGHT-64-49);
//    self.myView.frame = CGRectContainsPoint(WIDTH, 64);
//    self.timeBtn.layer.borderWidth = 0;
//    self.picBtn.layer.borderWidth = 1;
//    self.picBtn.layer.cornerRadius = 5;
//    self.picBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    [self.picTable reloadData];
}
#pragma mark 点击发布
- (void)add{
    publishViewController *pblish = [[publishViewController alloc]init];
    pblish.delegate = self;
    
    pblish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pblish animated:YES];
    
}
#pragma mark 数据处理
- (void)dataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *idDic = @{@"userid":@"1",
                                @"otheruserid":@"2"};
        [dataService timeAxisDic:idDic AndWidth:^(NSDictionary *resultDic) {
            NSArray *arr = [resultDic objectForKey:@"result"];
             NSLog(@"%@",arr);
            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in arr) {
                timeaxisModel *model = [[timeaxisModel alloc]init];
                
                model.content = [dic objectForKey:@"timeaxis_content"];
                model.time = [dic objectForKey:@"timeaxis_time"];
                model.date = [dic objectForKey:@"timeaxis_date"];
                model.timeid = [dic objectForKey:@"timeaxis_id"];
                [self.sourceArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
               
            });
        } addWidth:^(NSDictionary *error) {
            NSLog(@"error");
        }];
    });
}

@end
