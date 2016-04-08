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
    self.sendDic = [[NSDictionary alloc]init];
    [self dataSource];
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
    [self.view addSubview:_scroll];
    self.scroll.contentSize = CGSizeMake(WIDTH*2, _scroll.frame.size.height);
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    
    
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _scroll.frame.size.height)];
    [self.scroll addSubview:_timeView];
    self.picView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, _scroll.frame.size.height)];
    [self.scroll addSubview:_picView];
    
    [self header];
    [self myTableView];

    
}
#pragma mark 代理方法，获得返回值
- (void)sendMethod:(NSDictionary *)send{
    self.sendDic = send;
    NSLog(@"%@", _sendDic);
    
   
    [self.dateArr addObject:[send objectForKey:@"date"]];
    [self.timeArr addObject:[send objectForKey:@"time"]];
    [self.contentArr addObject:[send objectForKey:@"content"]];
    
    [self.table reloadData];
}
#pragma mark tableView
- (void)myTableView{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
    [self.timeView addSubview:_table];
    self.table.backgroundColor = MICOLOR;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.picTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
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
        return _contentArr.count;
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
        
    timelistcell *cell = [tableView dequeueReusableCellWithIdentifier:@"dropLove"];
        if (cell == nil) {
            cell = [[timelistcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dropLove"];
        }
        
        cell.backgroundColor = MICOLOR;
        cell.dateLabel1.text = [_dateArr[indexPath.row] substringFromIndex:8];
        cell.dateLabel2.text = [_dateArr[indexPath.row] substringToIndex:7];
        cell.heartImage.image = [UIImage imageNamed:@"heart"];
        cell.contentlabel.text = _contentArr[indexPath.row];
        
        [cell setHeight:_contentArr[indexPath.row]];
        self.height = cell.frame.size.height;
        
//        cell.timeLabel.text = [_timeArr[indexPath.row] substringToIndex:5];
        cell.timeLabel.text = _timeArr[indexPath.row];
        [cell.btn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        return cell;
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
//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:_table]) {
        commentViewController *comment = [[commentViewController alloc]init];
        
        comment.dateStr1 = [_dateArr[indexPath.row] substringFromIndex:8];
        comment.dateStr2 = [_dateArr[indexPath.row] substringToIndex:7];
        comment.contentStr = _contentArr[indexPath.row];
        comment.timeStr = [_timeArr[indexPath.row] substringToIndex:5];
        comment.headHeight = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
        [self presentViewController:comment animated:YES completion:nil];
    }
}
#pragma mark 顶部
- (void)header{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:_headerView];
    self.headerView.backgroundColor = COLOR_MINE;
    
    UIButton *timeBtn = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH/2-30-9) , 10, 30, 24)];
    [self.headerView addSubview:timeBtn];
    [timeBtn setTitle: @"时光" forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeBtn.titleLabel.font = FONT(13);
    [timeBtn addTarget:self action:@selector(timeAxis) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(timeBtn.frame.origin.x+timeBtn.frame.size.width + 10, 10, 2, 24)];
    [self.headerView addSubview:linelabel];
    linelabel.backgroundColor = [UIColor whiteColor];
    
    UIButton *picBtn = [[UIButton alloc]initWithFrame:CGRectMake(linelabel.frame.size.width+linelabel.frame.origin.x + 9, 10, 30, 24)];
    [self.headerView addSubview:picBtn];
    [picBtn setTitle: @"相册" forState:UIControlStateNormal];
    [picBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    picBtn.titleLabel.font = FONT(13);
    [picBtn addTarget:self action:@selector(picAxis) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-24-10, 12, 20, 20)];
    [self.headerView addSubview:photoBtn];
    [photoBtn setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 时光栏
- (void)timeAxis{
    self.scroll.contentOffset = CGPointMake(0, 0);
    
}
#pragma mark 相册栏
- (void)picAxis{
     self.scroll.contentOffset = CGPointMake(WIDTH, 0);
    [self.picTable reloadData];
}
#pragma mark 点击发布
- (void)add{
    publishViewController *pblish = [[publishViewController alloc]init];
    pblish.delegate = self;
    [self presentViewController:pblish animated:YES completion:nil];
    
}
#pragma mark 数据处理
- (void)dataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [dataService timeAxisAddWidth:^(NSDictionary *resultDic) {
            self.dic = [[NSDictionary alloc]initWithDictionary:resultDic];

            NSArray *arr = [_dic objectForKey:@"result"];
            self.contentArr = [NSMutableArray arrayWithCapacity:0];
            self.timeArr = [NSMutableArray arrayWithCapacity:0];
          
            self.dateArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in arr) {
                [self.contentArr addObject:[dic objectForKey:@"commenttime_content"]];
                [self.timeArr addObject:[dic objectForKey:@"commenttime_time"]];
                [self.dateArr addObject:[dic objectForKey:@"commenttime_date"]];
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
