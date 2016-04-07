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
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
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
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-30-10, 12, 30, 20)];
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
    socialModel *model = [[socialModel alloc]init];
    model = _sourceArr[_sourceArr.count - 1 - indexPath.row];
    socialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialId"];
    if (cell == nil) {
        cell = [[socialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialId"];
    }
    cell.deleteBtn.hidden = YES;

    if ([model.userid isEqualToString:[dataService myUserId]]) {
        cell.deleteBtn.hidden = NO;
        [cell.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [cell.deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cell.deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.deleteBtn.tag = indexPath.row;
    }else{
        
    }
    
    cell.contentLab.text = model.content;
    cell.headerLab.text = model.name;
    cell.timeLab.text = model.time;
    
//    cell.contentLab.text = _contentArr[indexPath.row];
//    cell.headerLab.text = _nameArr[indexPath.row];
//    cell.timeLab.text = _timeArr[indexPath.row];
    
    [cell setHeight:model.content];
    self.height = cell.frame.size.height;
    //头像路径
    NSString *path = [NSString stringWithFormat:@"/Applications/MAMP/htdocs/myLove/image/header/%@",model.headerImg];
    cell.headerImg.image = [UIImage imageWithContentsOfFile:path];
    
    [cell.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];

    return cell;
}
- (void)deleteMethod:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除心情之后将无法恢复，确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sourceArr removeObjectAtIndex:sender.tag];
        [self.table reloadData];
//
#warning 删除数据库内容
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    socialcommentViewController *comment = [[socialcommentViewController alloc]init];
    
    socialModel *model = [[socialModel alloc]init];
    model = self.sourceArr[indexPath.row];
    
    comment.name = model.name;
    comment.date = model.date;
    comment.time = model.time ;
    comment.content = model.content;
    comment.headerImgStr = model.headerImg ;
    
    comment.height = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
    [self presentViewController:comment animated:YES completion:nil];
    

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_height == 0) {
        return 1;
    }else{
        return _height;
    }
}
- (void)dataSource{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.userId = [dataService myUserId];
        
        NSDictionary *idDic = @{@"userid":_userId};
        [dataService socialDic:idDic AndWidth:^(NSDictionary *resultDic){
            NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:resultDic];
            
            NSArray *arr = [dic objectForKey:@"result"];
            
//            self.contentArr = [NSMutableArray arrayWithCapacity:0];
//            self.headerImgArr = [NSMutableArray arrayWithCapacity:0];
//            self.nameArr = [NSMutableArray arrayWithCapacity:0];
//            self.timeArr = [NSMutableArray arrayWithCapacity:0];
//            self.dateArr = [NSMutableArray arrayWithCapacity:0];
            
            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in arr) {
                socialModel *model = [[socialModel alloc]init];
                
                model.content = [dic objectForKey:@"social_content"];
                model.headerImg = [dic objectForKey:@"user_headerimage"];
                model.date = [dic objectForKey:@"social_date"];
                model.time = [dic objectForKey:@"social_time"];
                model.name = [dic objectForKey:@"user_name"];
                model.userid = [dic objectForKey:@"t_user_user_id"];
                [self.sourceArr addObject:model];
                
//                [self.contentArr addObject:[dic objectForKey:@"social_content"]];
//                [self.headerImgArr addObject:[dic objectForKey:@"user_headerimage"]];
//                [self.dateArr addObject:[dic objectForKey:@"social_date"]];
//                [self.timeArr addObject:[dic objectForKey:@"social_time"]];
//                [self.nameArr addObject:[dic objectForKey:@"user_name"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
                
            });
        } addWidth:^(NSDictionary *error) {
            
        }];
    });
}
@end
