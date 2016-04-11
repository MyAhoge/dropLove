//
//  socialPublishController.m
//  dropLove
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "socialPublishController.h"
#import "dropHeader.h"

@interface socialPublishController ()<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
}
@property (strong, nonatomic) CLLocationManager* locationManager;

@property (strong, nonatomic) UIView *view1;

@end

@implementation socialPublishController



- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = MICOLOR;
    [self topMethod];
    [self mainMethod];
    
}

- (void)topMethod{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12.5, 10, 20)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-24-10, 12, 30, 20)];
    [headerView addSubview:photoBtn];
    photoBtn.titleLabel.font = FONT(15);
    [photoBtn setTitle:@"发布" forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 输入框和图片位置
- (void)mainMethod{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 200)];
    [self.view addSubview:_view1];
    self.view1.backgroundColor = [UIColor whiteColor];
    
    self.text1 = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, WIDTH, 80)];
    [self.view1 addSubview:_text1];
    
    self.text1.font = FONT(15);
    self.text1.scrollEnabled = YES;
    //+
    UIButton *imageViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(_text1.frame.origin.x, _view1.frame.size.height - 10 - (WIDTH-50)/4, (WIDTH-50)/4, (WIDTH-50)/4)];
    [self.view1 addSubview:imageViewBtn];
    imageViewBtn.layer.borderWidth = 2;
    imageViewBtn.layer.borderColor = MICOLOR.CGColor;
    [imageViewBtn addTarget:self action:@selector(photoAlert) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewBtn.frame.size.width/4, imageViewBtn.frame.size.width/2-1, imageViewBtn.frame.size.width/2, 2)];
    [imageViewBtn addSubview:hLabel];
    hLabel.backgroundColor = MICOLOR;
    UILabel *sLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewBtn.frame.size.width/2-1, imageViewBtn.frame.size.width/4, 2, imageViewBtn.frame.size.width/2)];
    [imageViewBtn addSubview:sLabel];
    sLabel.backgroundColor = MICOLOR;
//    //image
//    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewBtn.frame.size.width+imageViewBtn.frame.origin.x, imageViewBtn.frame.origin.y, 100, 100)];
//    [view1 addSubview:_imageView];
}

#pragma mark 弹出提示框添加图片
- (void)photoAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self click];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark 调用相册
- (void)photo{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark 调用摄像头
- (void)camera{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
//#pragma mark choose图片
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    //获取沙盒路径
//    self.homePath = [[NSHomeDirectory() stringByAppendingString:@"/documents"] stringByAppendingString:@"/bgimage.png"];
//    //把图片直接保存到指定的路径
//    [UIImagePNGRepresentation(image) writeToFile:_homePath atomically:YES];
//    [self.imgArr addObject:[UIImage imageWithContentsOfFile:_homePath]];
//    
//    self.imageView.image = [UIImage imageWithContentsOfFile:_homePath];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
#pragma mark 发布
- (void)add{
    [self locaTime];
    
    if (_imageViewArr.count == 0) {
        self.dic = @{@"content":self.text1.text,
                              @"time":[_prettyVersion substringFromIndex:12],
                              @"date":[_prettyVersion substringToIndex:10],
                              @"userid":@1};
    }else{
        self.dic = @{@"content":self.text1.text,
                              @"time":[_prettyVersion substringFromIndex:12],
                              @"date":[_prettyVersion substringToIndex:10],
                              @"userid":@1,
                              @"imageArr":_imageViewArr};
    }

    if (_delegate != nil && [_delegate respondsToSelector:@selector(socialSendMethod:)]) {
        [_delegate socialSendMethod:_dic];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)backMethod{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)locaTime{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //cccc 星期全名 MM月全名
    //    [dateFormat setDateFormat:@"cccc MM dd, yyyy hh:mm aa"];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm aa"];
    self.prettyVersion = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"%@", _prettyVersion);
}


#pragma mark - 点击添加图片按钮
- (void)click{
    
    ImageViewController *vc=[[ImageViewController alloc]init];
    
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark - 代理带回来的图片信息
- (void)turnImages:(NSMutableArray *)selectAllImages{
    //    view1.frame.size.height-(WIDTH-50)/4-10
    self.imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(107.5, _view1.frame.size.height-(WIDTH-50)/4-10, [UIScreen mainScreen].bounds.size.width - 20, (WIDTH-50)/4)];
    
    self.imageScroll.backgroundColor = [UIColor whiteColor];
    
    self.imageScroll.contentOffset = CGPointMake(20, 320);
    
    self.imageScroll.contentSize = CGSizeMake(selectAllImages.count*(APPWIDTH-80)/5+selectAllImages.count*10, (WIDTH-50)/4);
    
    self.imageScroll.showsVerticalScrollIndicator = NO;
    
    NSMutableArray *lessTenImageArr = [NSMutableArray arrayWithCapacity:0];
    
    if (selectAllImages.count >10) {
        
        for (int i = 0; i<10; i++) {
            
            [lessTenImageArr addObject:selectAllImages[i]];
        }
    }else{
        
        lessTenImageArr = selectAllImages;
        
    }
    self.imageViewArr = lessTenImageArr;
    
    for (int i = 0; i<lessTenImageArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*((WIDTH-50)/4+10), 0, (WIDTH-50)/4, (WIDTH-50)/4)];
        
        imageView.image = lessTenImageArr[i];
        
        imageView.tag = i+1000;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        
        [imageView setUserInteractionEnabled:YES];
        
        [imageView addGestureRecognizer:longPress];
        
        [self.imageScroll addSubview:imageView];
    }
    [self.view1 addSubview:self.imageScroll];
}

- (void)longPress:(UIGestureRecognizer *)sender{
    
    if (sender.state ==  UIGestureRecognizerStateBegan  ) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH-50)/4-20, 0, 20, 20)];
        
        btn.backgroundColor = [UIColor orangeColor];
        
        btn.hidden = NO;
        
        btn.tag = [sender view].tag;
        
        [btn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self.imageScroll viewWithTag:[sender view].tag] addSubview:btn];
    }
    
    
}

- (void)deleteImage:(UIButton *)sender{
    //
    for (long int i = sender.tag; i<self.imageViewArr.count+1000-1; i++) {
        
        NSLog(@"=======%ld",sender.tag);
        
        UIImageView *before = [self.imageScroll viewWithTag:i];
        
        UIImageView *afterImage = [self.imageScroll viewWithTag:i+1];
        
        before.image = afterImage.image;
    }
    
    [[self.imageScroll viewWithTag:self.imageViewArr.count+1000-1] removeFromSuperview];
    
    [self.imageViewArr removeObjectAtIndex:sender.tag-1000];
    
    self.imageScroll.contentSize = CGSizeMake(self.imageViewArr.count*(WIDTH-50)/4+self.imageViewArr.count*10, (WIDTH-50)/4);
    
    
    [sender setHidden:YES];
}

@end
