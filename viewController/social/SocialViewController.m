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
    self.navigationItem.title = @"社区";
    [self.navigationController.navigationBar setBarTintColor:COLOR_MINE];
    //
    UIBarButtonItem *photoBtn = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = photoBtn;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    //去掉分割线
    //    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self dataSource];
    
}
#pragma mark 代理传值方法
- (void)socialSendMethod:(NSDictionary *)sender{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.sendDic = sender;
        socialModel *model = [[socialModel alloc]init];
        
        [dataService socialAddDataDic:sender addWith:^(NSDictionary *resultDic) {
            
            NSLog(@"%@", resultDic);
            
        } addWith:^(NSDictionary *errorDic) {
            
        }];
        
        model.content = [sender objectForKey:@"content"];
        model.date = [sender objectForKey:@"date"];
        model.time = [sender objectForKey:@"time"];
        model.imgArr = [sender objectForKey:@"imageArr"];
        [self.sourceArr addObject:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self dataSource];
            [self.table reloadData];
        });
    });
   
}
- (void)add{
    socialPublishController *publish = [[socialPublishController alloc]init];
    publish.delegate = self;
//    [self presentViewController:publish animated:YES completion:nil];
    publish.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:publish animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    socialModel *model = [[socialModel alloc]init];
    model = _sourceArr[_sourceArr.count - 1 - indexPath.row];
    
    if (model.imgArr.count == 0) {
        
        socialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialId"];
        if (cell == nil) {
            cell = [[socialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialId"];
        }
        cell.deleteBtn.hidden = YES;
        
        if ([model.userid isEqualToString:[dataService myUserId]]) {
            cell.deleteBtn.hidden = NO;
            
//            [cell.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//            [cell.deleteBtn setTitleColor:COLOR(167, 167, 172, 1) forState:UIControlStateNormal];
            [cell.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [cell.deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.tag = _sourceArr.count - 1 - indexPath.row;
        }else{
            
        }
        
        cell.contentLab.text = model.content;
        cell.headerLab.text = model.name;
        cell.timeLab.text = model.time;
        
        [cell setHeight:model.content];
        self.height = cell.frame.size.height;
        //头像路径
        NSString *path = [NSString stringWithFormat:@"/Applications/MAMP/htdocs/myLove/image/header/%@",model.headerImg];
        cell.headerImg.image = [UIImage imageWithContentsOfFile:path];
        
        [cell.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        return cell;
    }else{
        socialImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialImgCellId"];
        if (cell == nil) {
            cell = [[socialImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialImgCellId"];
        }
        cell.deleteBtn.hidden = YES;
        
        if ([model.userid isEqualToString:[dataService myUserId]]) {
            cell.deleteBtn.hidden = NO;
            [cell.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [cell.deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.tag = _sourceArr.count - 1 - indexPath.row;
        }else{
            
        }
        cell.contentLab.text = model.content;
        cell.headerLab.text = model.name;
        cell.timeLab.text = model.time;
        
      self.labHeight = [cell setHeight:model.content];
        self.height = cell.frame.size.height;
        //头像路径
        NSString *path = [NSString stringWithFormat:@"/Applications/MAMP/htdocs/myLove/image/header/%@",model.headerImg];
        cell.headerImg.image = [UIImage imageWithContentsOfFile:path];
        
        [cell.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        
        NSLog(@"?>>>>>%@", model.imgArr);
        
        if (model.imgArr.count == 1) {
            cell.image1.image = model.imgArr[0];
        }else if(model.imgArr.count == 2){
            cell.image1.image = model.imgArr[0];
            cell.image2.image = model.imgArr[1];
        }else if (model.imgArr.count == 3){
            cell.image1.image = model.imgArr[0];
            cell.image2.image = model.imgArr[1];
            cell.image3.image = model.imgArr[2];
        }else{
            
        }
        return cell;
    }
    
}
#pragma mark 删除
- (void)deleteMethod:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除心情之后将无法恢复，确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary *dic = @{@"socialid":(socialModel *)[_sourceArr[sender.tag] socialId]};
        [dataService socialdelete:dic andWithSucess:^(NSDictionary *resultDic) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    socialcommentViewController *comment = [[socialcommentViewController alloc]init];
    
    socialModel *model = [[socialModel alloc]init];
    model = self.sourceArr[_sourceArr.count - 1 - indexPath.row];
    
    comment.name         = model.name;
    comment.date         = model.date;
    comment.time         = model.time;
    comment.content      = model.content;
    comment.headerImgStr = model.headerImg ;
    comment.imgArr       = model.imgArr;
    comment.height = _labHeight;
//    comment.height = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
//    [self presentViewController:comment animated:YES completion:nil];
    comment.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:comment animated:YES];
  
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
            
            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in arr) {
                socialModel *model = [[socialModel alloc]init];
                
                model.content = [dic objectForKey:@"social_content"];
                model.headerImg = [dic objectForKey:@"user_headerimage"];
                model.date = [dic objectForKey:@"social_date"];
                model.time = [dic objectForKey:@"social_time"];
                model.name = [dic objectForKey:@"user_name"];
                model.userid = [dic objectForKey:@"t_user_user_id"];
                model.socialId = [dic objectForKey:@"social_id"];
                
                [self.sourceArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        } addWidth:^(NSDictionary *error) {
            
        }];
    });
}
@end
