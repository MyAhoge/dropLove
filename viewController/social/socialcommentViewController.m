//
//  socialcommentViewController.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialcommentViewController.h"
#import "dropHeader.h"


@implementation socialcommentViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.commentMutArr = [NSMutableArray arrayWithCapacity:0];
    [self myTable];
    
    [self commentMethod];
}
#pragma mark table
- (void)myTable{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-40) style:UITableViewStylePlain];
    self.table.backgroundColor = MICOLOR;
    [self.view addSubview:_table];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    UIView *tabHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _height+WIDTH*_imgArr.count)];
    self.table.tableHeaderView = tabHeaderView;
    
    self.headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_headerImg.frame.origin.x+_headerImg.frame.size.width+10, 10, 100, 20)];
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y+_nameLab.frame.size.height+10, 80, 20)];
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height+10, WIDTH-20, _height)];
    self.commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-20, _nameLab.frame.origin.y, 25, 20)];

    
    for (int i = 0; i < _imgArr.count; i ++) {
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10 , 10+_contentLab.frame.origin.y+_contentLab.frame.size.height+(WIDTH- 20+10)*i, (WIDTH- 20), (WIDTH- 20))];
            [tabHeaderView addSubview:img];
            img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_imgArr[i] objectForKey:@"socialimg_path"]]]];
       
    }
    
    [tabHeaderView addSubview:_headerImg];
    [tabHeaderView addSubview:_nameLab];
    [tabHeaderView addSubview:_timeLab];
    [tabHeaderView addSubview:_contentLab];
    [tabHeaderView addSubview:_commentBtn];
    //头像
    NSURL *url = [NSURL URLWithString:_headerImgStr];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    self.headerImg.image = [UIImage imageWithData:imgData];
    
    self.nameLab.text    = _name;
    self.timeLab.text    = _time;
    self.contentLab.text = _content;
    [self.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    
    self.nameLab.font    = FONT(13);
    self.timeLab.font    = FONT(13);
    self.contentLab.font = FONT(13);
    self.contentLab.numberOfLines = 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    socialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialCommentCellId"];
    if (cell == nil) {
        cell = [[socialCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialCommentCellId"];
    }
    
    cell.contentLab.text = _commentMutArr[indexPath.row];
    
    [cell setHeight:_commentMutArr[indexPath.row]];
    self.cellHeight = cell.frame.size.height;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentMutArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

#pragma mark 输入框
- (void)commentMethod{
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40-64, WIDTH, 40)];
    [self.view addSubview:_footView];
    self.footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-10-50, 30)];
    [self.footView addSubview:_textView];
  
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
        NSString *str = _textView.text;
        [self.commentMutArr addObject:str];
        NSLog(@"%@", _commentMutArr);
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
- (void)socialDataService{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
        });
    });
}

//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
