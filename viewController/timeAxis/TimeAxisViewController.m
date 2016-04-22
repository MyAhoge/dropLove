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
    
    NSUserDefaults *userDic = [NSUserDefaults standardUserDefaults];
    NSString *userMessage = [userDic objectForKey:@"message"];
    NSLog(@"%@", userMessage);
    
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
            NSLog(@"时光轴发布成功-result%@",resultDic);
            
            NSArray *arr = [send objectForKey:@"imgarr"];
            if (arr.count > 0) {
                [dataService timeaxisSetImg:[send objectForKey:@"imgarr"] andTimeId:[resultDic objectForKey:@"timeaxis_id"]  andSuccess:^(NSString *str) {
                    NSLog(@"上传图片成功！-%@",str);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self updataTimeAxis];
                    });
                } andFail:^(NSString *error) {
                    NSLog(@"上传图片失败！-%@", error);
                }];
            }
        } addWith:^(NSDictionary *errorDic) {
            
        }];
        timeaxisModel *model = [[timeaxisModel alloc]init];
        
        model.content = [send objectForKey:@"content"];
        model.date = [send objectForKey:@"date"];
        model.time = [send objectForKey:@"time"];
        model.imgArr = [send objectForKey:@"imgarr"];
        [self.sourceArr addObject:model];
        
        [self updataTimeAxis];
    });
}
#pragma mark tableView
- (void)myTableView{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    [self.timeView addSubview:_table];
    self.table.backgroundColor = [UIColor whiteColor];
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
    
    //加载圆圈
    [self updataTimeAxis];
}

#pragma mark 无数据时刷新符号
- (void)updataTimeAxis{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    [refresh addTarget:self action:@selector(dataSource:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refresh];
    [refresh beginRefreshing];
    [self dataSource:refresh];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_table]) {
        return _sourceArr.count;
    }else{
        return _imgPathArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_table]) {
        if (_height == 0) {
            return 1;
        }else{
            return _height;
        }
    }else{
        return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    timeaxisModel *timeModel = [[timeaxisModel alloc]init];
    timeModel = self.sourceArr[_sourceArr.count - 1 - indexPath.row];
    
    self.imgPathArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *imgDic in _timeidArr) {
        if ([timeModel.timeid isEqualToString:[imgDic objectForKey:@"t_timeaxis_timeaxis_id"]]) {
            [self.imgPathArr addObject:[imgDic objectForKey:@"timeaxisimg_path"]];
        }
    }
    if ([tableView isEqual:_table]) {
        if (_imgPathArr.count == 0) {
            NSLog(@"无图cell%ld,%@", indexPath.row, _imgPathArr);
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
            cell.deletebtn.tag = _sourceArr.count - 1 - indexPath.row;
            [cell.deletebtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
            
             return cell;
        }else{
            NSLog(@"有图cell%ld,%@", indexPath.row, _imgPathArr);
            timeListimagecell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeListimagecellid"];
            if (cell == nil) {
                cell = [[timeListimagecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"timeListimagecellid"];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   
                    if (_imgPathArr.count == 0) {
                        
                    }else if (_imgPathArr.count == 1) {
                        self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                    }else if(_imgPathArr.count == 2){
                        self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                        self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                    }else if (_imgPathArr.count == 3){
                        self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                        self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                        self.img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[2]]]];
                    }else{
                        self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                        self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                        self.img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[2]]]];
                        
                        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-10-10, cell.image3.frame.size.height-10, 20, 20)];
                        label.text = [NSString stringWithFormat:@"共%ld张",timeModel.imgArr.count];
                        label.font = FONT(13);
                        label.textAlignment = NSTextAlignmentRight;
                        [cell.image3 addSubview:label];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell setHeight:timeModel.content];
                        self.height = cell.frame.size.height;
                        
                        [cell.deletebtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                        cell.deletebtn.tag = _sourceArr.count - 1 - indexPath.row;
                        [cell.deletebtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
                        
                        cell.dateLabel1.text = [timeModel.date substringFromIndex:8];
                        cell.dateLabel2.text = [timeModel.date substringToIndex:7];
                        cell.timeLabel.text = timeModel.time;
                        cell.contentlabel.text = timeModel.content;
                        
                        cell.heartImage.image = [UIImage imageNamed:@"heart"];
                        
                        cell.image1.image = _img1;
                        cell.image2.image = _img2;
                        cell.image3.image = _img3;
                    });
                });
            }
            cell.backgroundColor = MICOLOR;
            NSLog(@"cell---%f", cell.contentView.frame.size.height);
            return cell;
        }
    }else{
        piclistcell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"piclistid"];
        if (cell2 == nil) {
            cell2 = [[piclistcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"piclistid"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.height = cell2.frame.size.height;
                if (_imgPathArr.count == 0) {
                    
                }else if (_imgPathArr.count == 1) {
                    self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                }else if(_imgPathArr.count == 2){
                    self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                    self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                }else if (_imgPathArr.count == 3){
                    self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                    self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                    self.img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[2]]]];
                }else{
                    self.img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[0]]]];
                    self.img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[1]]]];
                    self.img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPathArr[2]]]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    [cell2.deletebtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//                    cell2.deletebtn.tag = _sourceArr.count - 1 - indexPath.row;
//                    [cell2.deletebtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
//                    [cell2.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
                    
//                    cell2.dateLabel1.text = [timeModel.date substringFromIndex:8];
//                    cell2.dateLabel2.text = [timeModel.date substringToIndex:7];
//                    cell2.timeLabel.text = timeModel.time;
//                    cell2.contentlabel.text = timeModel.content;
                    
                    cell2.heartImage.image = [UIImage imageNamed:@"heart"];
                    
                    cell2.image1.image = _img1;
                    cell2.image2.image = _img2;
                    cell2.image3.image = _img3;
                });
            });
        }
        cell2.backgroundColor = MICOLOR;
        return cell2;
    }
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:1 inSection:0];
    NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
    [self.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
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
        model = self.sourceArr[_sourceArr.count - 1 - indexPath.row];
        
        comment.dateStr1 = [model.date substringFromIndex:8];
        comment.dateStr2 = [model.date substringToIndex:7];
        comment.contentStr = model.content;
        comment.timeStr = [model.time substringToIndex:5];
        
       
        
        self.imgPathArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *imgDic in _timeidArr) {
            if ([model.timeid isEqualToString:[imgDic objectForKey:@"t_timeaxis_timeaxis_id"]]) {
                [self.imgPathArr addObject:[imgDic objectForKey:@"timeaxisimg_path"]];
            }
        }
        
        comment.imgArr = _imgPathArr;
        
        if (_imgPathArr.count > 0) {
            comment.headHeight = ((timeListimagecell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height - 70 - (WIDTH_MY-100)/3;
        }else{
            comment.headHeight = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
        }
        //隐藏底部导航
        comment.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comment animated:YES];
    }
}

#pragma mark 时光栏
- (void)timeAxis{
    self.myView.frame = CGRectMake(0, 0, WIDTH * 2, HEIGHT-64-49);
    [self updataTimeAxis];
}
#pragma mark 相册栏
- (void)picAxis{
    self.myView.frame = CGRectMake(-WIDTH, 0, WIDTH * 2, HEIGHT-64-49);
}
#pragma mark 点击发布
- (void)add{
    publishViewController *pblish = [[publishViewController alloc]init];
    pblish.delegate = self;
    
    pblish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pblish animated:YES];
    
}
#pragma mark 数据处理
- (void)dataSource:(UIRefreshControl*)send{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *idDic = @{@"userid":[[userDef objectForKey:@"data"] objectForKey:@"user_id"],
                                @"otheruserid":@"2"};
        
        [dataService timeAxisDic:idDic AndWidth:^(NSDictionary *resultDic) {
            NSArray *dataArr = [resultDic objectForKey:@"result"];
            NSArray *imgPathArr = [resultDic objectForKey:@"imgpath"];
            
            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
            self.timeidArr = [NSMutableArray arrayWithArray:imgPathArr];
            
            
            for (NSDictionary *dic in dataArr) {
                timeaxisModel *model = [[timeaxisModel alloc]init];
//                self.imgPathArr = [NSMutableArray arrayWithCapacity:0];
                
                model.content = [dic objectForKey:@"timeaxis_content"];
                model.time = [dic objectForKey:@"timeaxis_time"];
                model.date = [dic objectForKey:@"timeaxis_date"];
                model.timeid = [dic objectForKey:@"timeaxis_id"];
                [self.sourceArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
                [send endRefreshing];
            });
        } addWidth:^(NSDictionary *error) {
            NSLog(@"error");
        }];
    });
}
@end
