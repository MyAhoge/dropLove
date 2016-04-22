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
    
    [self updata];
    
}
#pragma mark 无数据时刷新符号
- (void)updata{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    [refresh addTarget:self action:@selector(dataSource:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refresh];
    [refresh beginRefreshing];
    [self dataSource:refresh];
    
}
#pragma mark 代理传值方法
- (void)socialSendMethod:(NSDictionary *)sender{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.sendDic = sender;
        socialModel *model = [[socialModel alloc]init];
        [dataService socialAddDataDic:sender addWith:^(NSDictionary *resultDic) {
//            NSLog(@"social添加数据成功-%@", resultDic);
            [dataService socialSetImg:[sender objectForKey:@"imageArr"] andSocialId:[resultDic objectForKey:@"result"]  andSuccess:^(NSString *result) {
                NSLog(@"上传图片成功-%@", result);
            } andFail:^(NSString *result) {
                
            }];
            
        } addWith:^(NSDictionary *errorDic) {
            
        }];
        
        model.content = [sender objectForKey:@"content"];
        model.date = [sender objectForKey:@"date"];
        model.time = [sender objectForKey:@"time"];
        model.imgArr = [sender objectForKey:@"imageArr"];
        [self.sourceArr addObject:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updata];
        });
    });
}
- (void)add{
    socialPublishController *publish = [[socialPublishController alloc]init];
    publish.delegate = self;
    publish.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publish animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.labHeight = 0;
    socialModel *model = [[socialModel alloc]init];
    model = _sourceArr[_sourceArr.count - 1 - indexPath.row];
    
    if (model.imgArr.count == 0) {
        
        socialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialId"];
        if (cell == nil) {
            cell = [[socialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialId"];
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
            
            NSURL *url = [NSURL URLWithString:model.headerImg];
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            cell.headerImg.image = [UIImage imageWithData:imgData];
            
            [cell.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        }
        return cell;
    }else{
        socialImgCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"socialImgCellId"];
        if (cell1 == nil) {
            cell1 = [[socialImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialImgCellId"];
            
            cell1.deleteBtn.hidden = YES;
            
            if ([model.userid isEqualToString:[dataService myUserId]]) {
                cell1.deleteBtn.hidden = NO;
                [cell1.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                [cell1.deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchUpInside];
                cell1.deleteBtn.tag = _sourceArr.count - 1 - indexPath.row;
            }else{
                
            }
            cell1.contentLab.text = model.content;
            cell1.headerLab.text = model.name;
            cell1.timeLab.text = model.time;
            
            self.labHeight = [cell1 setHeight:model.content];
            self.height = cell1.frame.size.height;
            
            NSURL *url = [NSURL URLWithString:model.headerImg];
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            cell1.headerImg.image = [UIImage imageWithData:imgData];
            
            [cell1.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
            
            if (model.imgArr.count == 1) {
                cell1.image1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[0] objectForKey:@"socialimg_path"]]]];
            }else if(model.imgArr.count == 2){
                cell1.image1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[0] objectForKey:@"socialimg_path"]]]];
                cell1.image2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[1] objectForKey:@"socialimg_path"]]]];
            }else if (model.imgArr.count == 3){
                cell1.image1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[0] objectForKey:@"socialimg_path"]]]];
                cell1.image2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[1] objectForKey:@"socialimg_path"]]]];
                cell1.image3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[2] objectForKey:@"socialimg_path"]]]];
            }else{
                
                
                cell1.image1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[0] objectForKey:@"socialimg_path"]]]];
                cell1.image2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[1] objectForKey:@"socialimg_path"]]]];
                cell1.image3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.imgArr[2] objectForKey:@"socialimg_path"]]]];
                
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(cell1.image3.frame.size.width-10-40, cell1.image3.frame.size.height-10-20, 40, 20)];
                [cell1.image3 addSubview:lab];
                lab.text = [NSString stringWithFormat:@"共%ld张",model.imgArr.count];
                lab.font = FONT(10);
                lab.textAlignment = NSTextAlignmentRight;
                
            }
        }
       
        return cell1;
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
    //label的高
    if (model.imgArr.count > 0) {
        comment.height = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height - 110-(WIDTH-80)/3;
    }else{
        comment.height = ((timelistcell *)[tableView cellForRowAtIndexPath:indexPath]).contentView.frame.size.height - 110;
    }
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
//TODO:数据请求
- (void)dataSource:(UIRefreshControl *)send{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.userId = [dataService myUserId];
        
        NSDictionary *idDic = @{@"userid":_userId};
        
        [dataService socialDic:idDic AndWidth:^(NSDictionary *resultDic){
            NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:resultDic];
            NSLog(@"社区请求数据-%@", dic);
            NSArray *arr = [dic objectForKey:@"result"];
            
            self.sourceArr = [NSMutableArray arrayWithCapacity:0];
            
            NSArray *imgpathArr = [dic objectForKey:@"imgpath"];
            
            if (imgpathArr.count > 0) {
                for (NSDictionary *dic in arr) {
                    socialModel *model = [[socialModel alloc]init];
                    
                    model.content = [dic objectForKey:@"social_content"];
                    model.headerImg = [dic objectForKey:@"user_headerimage"];
                    model.date = [dic objectForKey:@"social_date"];
                    model.time = [dic objectForKey:@"social_time"];
                    model.name = [dic objectForKey:@"user_name"];
                    model.userid = [dic objectForKey:@"t_user_user_id"];
                    model.socialId = [dic objectForKey:@"social_id"];
                    model.imgArr = imgpathArr;
                    [self.sourceArr addObject:model];
                }
            }else{
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
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.table reloadData];
                
                [send endRefreshing];
            });
        } addWidth:^(NSDictionary *error) {
            
        }];
    });
}
@end
