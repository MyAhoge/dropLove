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
    
    [self topMethod];
    
    [self myTable];
    
    [self commentMethod];
}
#pragma mark table
- (void)myTable{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.table.backgroundColor = MICOLOR;
    [self.view addSubview:_table];
    self.table.delegate = self;
    self.table.dataSource = self;
    UIView *tabHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _height)];
    self.table.tableHeaderView = tabHeaderView;
    
    self.headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_headerImg.frame.origin.x+_headerImg.frame.size.width+10, 10, 100, 20)];
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.frame.origin.x, _nameLab.frame.origin.y+_nameLab.frame.size.height+10, 80, 20)];
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _headerImg.frame.origin.y+_headerImg.frame.size.height+10, WIDTH-20, _height-100)];
    self.commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-20, _nameLab.frame.origin.y, 25, 20)];
    
    
    [tabHeaderView addSubview:_headerImg];
    [tabHeaderView addSubview:_nameLab];
    [tabHeaderView addSubview:_timeLab];
    [tabHeaderView addSubview:_contentLab];
    [tabHeaderView addSubview:_commentBtn];
    
    NSString *path = [NSString stringWithFormat:@"/Applications/MAMP/htdocs/myLove/image/header/%@",_headerImgStr];
    
    self.headerImg.image = [UIImage imageWithContentsOfFile:path];;
    self.nameLab.text    = _name;
    self.timeLab.text    = _time;
    self.contentLab.text = _content;
    [self.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    
    self.nameLab.font    = FONT(13);
    self.timeLab.font    = FONT(13);
    self.contentLab.font = FONT(13);
    self.contentLab.numberOfLines = 0;
    
}
#pragma mark 顶部
- (void)topMethod{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor  =COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 25)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    socialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialCommentCellId"];
    if (cell == nil) {
        cell = [[socialCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"socialCommentCellId"];
    }
    NSLog(@"111%@", _commentMutArr);
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
#pragma mark 返回
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 输入框
- (void)commentMethod{
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-60, WIDTH, 60)];
    [self.view addSubview:_footView];
    self.footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-10-70, 40)];
    [self.footView addSubview:_textView];
//    self.textView.backgroundColor = MICOLOR;
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-20-40, 10, 40, 40)];
    [self.footView addSubview:sendBtn];
    sendBtn.layer.repeatDuration = 5;
    [sendBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendContentMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView.delegate = self;
}
#pragma mark 点击发送
-(void)sendContentMethod{
    [self.commentMutArr addObject:_textView.text];
    [self.table reloadData];
    self.textView.text = nil;
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
        frame.origin.y = HEIGHT-60;
        self.footView.frame = frame;
    }];
    return YES;
}
//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark 可找到键盘高度
//#pragma mark - keyboardHight
//-(void)viewWillAppear:(BOOL)animated{
//    [self registerForKeyboardNotifications];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//- (void)registerForKeyboardNotifications{
//    //使用NSNotificationCenter 鍵盤出現時
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)  name:UIKeyboardDidShowNotification object:nil];
//    //使用NSNotificationCenter 鍵盤隐藏時
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)  name:UIKeyboardWillHideNotification object:nil];
//}
//#pragma mark 键盘出来的事件处理，上移文本输入框。
//- (void)keyboardWillShow:(NSNotification *)notification{
//    
//    NSDictionary *userInfo = [notification userInfo];
//    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//    
//    // 根据老的 frame 设定新的 frame
//    CGRect newTextViewFrame = _textView.frame; // by michael
//    newTextViewFrame.origin.y = keyboardRect.origin.y - _textView.frame.size.height;
//    
//    // 键盘的动画时间，设定与其完全保持一致
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
//    
//    // 键盘的动画是变速的，设定与其完全保持一致
//    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
//    NSUInteger animationCurve;
//    [animationCurveObject getValue:&animationCurve];
//    
//    // 开始及执行动画
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
//    _textView.frame = newTextViewFrame;
//    [UIView commitAnimations];
//}
////键盘消失时的处理，文本输入框回到页面底部。
//- (void)keyboardWillHide:(NSNotification *)notification{
//    
//    NSDictionary* userInfo = [notification userInfo];
//    
//    // 键盘的动画时间，设定与其完全保持一致
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
//    
//    // 键盘的动画是变速的，设定与其完全保持一致
//    NSValue *animationCurveObject =[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
//    NSUInteger animationCurve;
//    [animationCurveObject getValue:&animationCurve];
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
//    CGRect newTextViewFrame = _textView.frame;
//    newTextViewFrame.origin.y = HEIGHT - _textView.frame.size.height;
//    _textView.frame = newTextViewFrame;
//    [UIView commitAnimations];
//}

@end
