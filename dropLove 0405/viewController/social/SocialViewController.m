//
//  SocialViewController.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "SocialViewController.h"
#import "dropHeader.h"  


@implementation SocialViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self topMethod];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    //去掉分割线
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self dataSource];
    
}

- (void)topMethod{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-30, 12, 60, 20)];
    [headerView addSubview:headerLabel];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.text = @"社区";
    headerLabel.font = FONT(18);
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-24-10, 12, 30, 20)];
    [headerView addSubview:photoBtn];
    photoBtn.titleLabel.font = FONT(15);
    [photoBtn setTitle:@"发布" forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
   
}
- (void)add{
    socialPublishController *publish = [[socialPublishController alloc]init];
    [self presentViewController:publish animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    socialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialId"];
    if (cell == nil) {
        cell = [[socialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialId"];
    }
    
    cell.contentLab.text = _contentArr[indexPath.row];
    cell.headerLab.text = _nameArr[indexPath.row];
    //头像路径
    NSString *path = [NSString stringWithFormat:@"/Applications/MAMP/htdocs/myLove/image/header/%@",_headerImgArr[indexPath.row]];
    cell.headerImg.image = [UIImage imageWithContentsOfFile:path];
    
    [cell setHeight:_contentArr[indexPath.row]];
    self.height = cell.frame.size.height;
    
    [cell.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _height;
}
- (void)dataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [dataService socialAddWidth:^(NSDictionary *resultDic) {
            NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:resultDic];
            
            NSArray *arr = [dic objectForKey:@"result"];
            
            self.contentArr = [NSMutableArray arrayWithCapacity:0];
            self.headerImgArr = [NSMutableArray arrayWithCapacity:0];
            self.nameArr = [NSMutableArray arrayWithCapacity:0];
            self.timeArr = [NSMutableArray arrayWithCapacity:0];
            self.dateArr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in arr) {
                [self.contentArr addObject:[dic objectForKey:@"social_content"]];
                [self.headerImgArr addObject:[dic objectForKey:@"user_headerimage"]];
                [self.dateArr addObject:[dic objectForKey:@"social_date"]];
                [self.timeArr addObject:[dic objectForKey:@"social_time"]];
                [self.nameArr addObject:[dic objectForKey:@"user_name"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
                
            });
        } addWidth:^(NSDictionary *error) {
            
        }];
    });
}
@end
