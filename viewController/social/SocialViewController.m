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
//- (void)test{
//    float x1  = 0,    x2=0.792, x3=2.160;
//    float x41 = 0.222,x42=0.221,x43=0.221,x44=2.212;
//    float x51 = 1.108,x52=0.114,x53=2.129,x54=2.147;
//    float x61 = 0.002,x62=0.001,x63=0,x64=0.001,x65=1.992,x66=0.997,x67=0,x68=3.013,x69=3.031;
//   
//    
//    float m1=(440*x1-128*x41+37*x42+37*x43+54*x44-34*x51-7*x52-7*x53+48*x54-202*x61-37*x62+110*x63-37*x64-20*x65+7*x66+110*x67+7*x68+62*x69)/440;
//    
//    float m2=(440*x2+80*x41+25*x42+25*x43-130*x44-130*x51+25*x52+25*x53+80*x54+30*x61-25*x62+110*x63-25*x64-180*x65-25*x66+110*x67-25*x68+30*x69)/440;
//    
//    float m3=(440*x3+48*x41-7*x42-7*x43-34*x44+54*x51+37*x52+37*x53-128*x54+62*x61+7*x62+110*x63+7*x64-20*x65-37*x66+110*x67-37*x68-202*x69)/440;
//    
////    0.441693--0.112666
////    333.695/440 =  0.75839773
////    332.743/440 = 0.75623409
//    NSLog(@"%.6f-%.6f-%.6f", m1,m2,m3);
//}

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
        
        [self dataSource];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    });
   
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
    publish.delegate = self;
    [self presentViewController:publish animated:YES completion:nil];
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
