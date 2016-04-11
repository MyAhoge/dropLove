//
//  publishViewController.m
//  dropLove
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "publishViewController.h"
#import "dropHeader.h"

@interface publishViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
}
@property (strong, nonatomic) CLLocationManager* locationManager;

@property (strong, nonatomic) UIView *view1;

@end

@implementation publishViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = MICOLOR;
    
    [self headerMethod];
    [self mainMethod];
    
    
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
    //    self.textStr = text1.text;
    //    NSLog(@"textstr%@", _textStr);
    
    UIButton *imageViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(_text1.frame.origin.x, _view1.frame.size.height-(WIDTH-50)/4-10, (WIDTH-50)/4, (WIDTH-50)/4)];
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
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewBtn.frame.size.width+imageViewBtn.frame.origin.x, imageViewBtn.frame.origin.y, 100, 100)];
    [self.view1 addSubview:_imageView];
    //定位信息
    UIView *mapView = [[UIView alloc]initWithFrame:CGRectMake(0, _view1.frame.origin.y+_view1.frame.size.height+20, WIDTH, 50)];
    [self.view addSubview:mapView];
    mapView.backgroundColor = [UIColor whiteColor];
    
    UIButton *mapBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 25)];
    [mapView addSubview:mapBtn];
    [mapBtn setImage:[UIImage imageNamed:@"mapimg"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(startMap) forControlEvents:UIControlEventTouchUpInside];
    
   self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(mapBtn.frame.size.width + mapBtn.frame.origin.x + 20, mapBtn.frame.origin.y, 100, mapBtn.frame.size.height)];
    [mapView addSubview:_cityLabel];
    self.cityLabel.text = @"我在···";
    self.cityLabel.font = FONT(13);
}
- (void)startMap{
    //开启定位
    [self startLocation];
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
#pragma mark choose图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取沙盒路径
    self.homePath = [[NSHomeDirectory() stringByAppendingString:@"/documents"] stringByAppendingString:@"/bgimage.png"];
    //把图片直接保存到指定的路径
    [UIImagePNGRepresentation(image) writeToFile:_homePath atomically:YES];
    [self.imgArr addObject:[UIImage imageWithContentsOfFile:_homePath]];
    
    self.imageView.image = [UIImage imageWithContentsOfFile:_homePath];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark 顶部
- (void)headerMethod{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    [self.view addSubview:topView];
    topView.backgroundColor = COLOR_MINE;
    
    UIView *headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = COLOR_MINE;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12.5, 10, 20)];
    [headerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-10-40, 10, 40, 20)];
    [headerView addSubview:sendBtn];
    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendToTime) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40, 10, 80, 20)];
    [headerView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"记录心情";
    label.font = FONT(18);
}
#pragma mark 返回按钮
- (void)backMethod{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 发布
- (void)sendToTime{
    [self locaTime];
    
    if (_imageViewArr.count == 0) {
        self.dic = @{@"content":_text1.text,
                     @"time":[_prettyVersion substringFromIndex:12],
                     @"date":[_prettyVersion substringToIndex:10],
                     @"userid":@1
                     };
    }else{
        self.dic = @{@"content":_text1.text,
                     @"time":[_prettyVersion substringFromIndex:12],
                     @"date":[_prettyVersion substringToIndex:10],
                     @"userid":@1,
                     @"imgarr":_imageViewArr
                 };
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(sendMethod:)]) {
        
        [_delegate sendMethod:_dic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark 定位
-(void)locationManager:(CLLocationManager *)manager

      didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
    }
}

#pragma mark  开始定位
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 8.0) {
        //使用期间
        [self.locationManager requestWhenInUseAuthorization];
        //始终
        //or [self.locationManage requestAlwaysAuthorization]
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark 定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [_locationManager stopUpdatingLocation];
        
        NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            for (CLPlacemark * placemark in placemarks) {
                NSDictionary *test = [placemark addressDictionary];
                //  Country(国家)  State(城市)  SubLocality(区)
                NSLog(@"City---%@", [test objectForKey:@"City"]);
                
                self.cityNameStr = [test objectForKey:@"City"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.cityLabel.text =[NSString stringWithFormat:@"我在 %@",_cityNameStr];
                    
                });
            }
        }];
    });
}

- (void)locaTime{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //cccc 星期全名 MM月全名
    //    [dateFormat setDateFormat:@"cccc MM dd, yyyy hh:mm aa"];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm aa"];
    self.prettyVersion = [dateFormat stringFromDate:[NSDate date]];
//    NSLog(@"%@", _prettyVersion);
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
