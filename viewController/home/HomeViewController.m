//
//  HomeViewController.m
//  dropLove
//
//  Created by administrator on 16/3/25.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "HomeViewController.h"
#import "dropHeader.h"

#import "chatViewController.h"
//#import "MapViewController.h"

@interface HomeViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
}
//定位
@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    BOOL isLogin = NO;
    if (isLogin == NO) {
        [UIView animateWithDuration:0 animations:^{
            loginViewController *login = [[loginViewController alloc]init];
            [self presentViewController:login animated:YES completion:nil];
            
        }];
    }
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    顶部导航
    
    //顶部导航栏
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"点滴爱";
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                    
                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    
                                                                    };
    
    
    
    //1.创建UIBarButtonItem对象
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemCamera target:self action:@selector(photo:)];
    
    //2.把UIBarButtonItem对象赋值给leftBarButtonItem或者rightBarButtonItem
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //
    //    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    //
    //    [self.view addSubview:self.headView];
    //
    //    self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    //
    //    self.topLabel.backgroundColor = COLOR_MINE;
    //
    //    [self.headView addSubview:self.topLabel];
    //
    //    self.mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    //
    //    self.mainLabel.backgroundColor = COLOR_MINE;
    //
    //    self.mainLabel.text = @"点滴爱";
    //
    //    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    //
    //    self.mainLabel.textColor = COLOR(255, 255, 255, 1);
    //
    //    self.mainLabel.font = FONT(15);
    //
    //    [self.headView addSubview:self.mainLabel];
    //
    //    self.changbgBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40, 30, 25, 25)];
    //
    //    [self.changbgBtn setImage:[UIImage imageNamed:@"112.png"] forState:UIControlStateNormal];
    //
    //    [self.changbgBtn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.headView addSubview:self.changbgBtn];
    //    middle 底部49
    
    self.middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-113)];
    
    //    self.middleView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.middleView];
    
    self.middleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    //获取沙盒路径
    NSString *homePath = [[NSHomeDirectory() stringByAppendingString:@"/documents"] stringByAppendingString:@"/bgimage.png"];
    if ([UIImage imageWithContentsOfFile:homePath]) {
        self.middleImage.image = [UIImage imageWithContentsOfFile:homePath];
    }else{
        self.middleImage.image = [UIImage imageNamed:@"bg.jpg"];
    }
    [self.middleView addSubview:self.middleImage];
    
    
    //    personView
    
    self.personView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 55)];
    
    self.personView.backgroundColor = COLOR(255, 255, 255, 0.4);
    
    [self.middleView addSubview:self.personView];
    
    self.manimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    
    self.manimage.image = [UIImage imageNamed:@"man.jpg"];
    
    self.manimage.layer.cornerRadius = 17.5;
    
    self.manimage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    //    self.manimage.layer.borderWidth = 1;
    //
    //    self.manimage.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    //
    [self.personView addSubview:self.manimage];
    
    self.mancityLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 45, 17)];
    
    self.mancityLabel.textAlignment = NSTextAlignmentLeft;
    
    self.mancityLabel.font = FONT(12);
    
    //    self.mancityLabel.text = @"苏州";
    
    self.mancityLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.mancityLabel];
    
    self.manweatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 31, 60, 17)];
    
    self.manweatherLabel.textAlignment = NSTextAlignmentLeft;
    
    self.manweatherLabel.font = FONT(12);
    
    //    self.manweatherLabel.text = @"雨";
    
    self.manweatherLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.manweatherLabel];
    
    self.mantempLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 31, 30, 17)];
    
    self.mantempLabel.textAlignment = NSTextAlignmentLeft;
    
    self.mantempLabel.font = FONT(12);
    
    //    self.mantempLabel.text = @"12℃";
    
    self.mantempLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.mantempLabel];
    
    
    self.womanimage = [[UIImageView alloc]initWithFrame:CGRectMake(_personView.frame.size.width-45, 10, 35, 35)];
    
    self.womanimage.image = [UIImage imageNamed:@"woman.jpg"];
    
    self.womanimage.layer.cornerRadius = 17.5;
    
    self.womanimage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    //    self.manimage.layer.borderWidth = 1;
    //
    //    self.manimage.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    //
    [self.personView addSubview:self.womanimage];
    
    self.womancityLabel = [[UILabel alloc]initWithFrame:CGRectMake(_personView.frame.size.width-100, 10, 45, 17)];
    
    self.womancityLabel.textAlignment = NSTextAlignmentRight;
    
    self.womancityLabel.font = FONT(12);
    
    self.womancityLabel.text = @"扬州";
    
    self.womancityLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.womancityLabel];
    
    self.womanweatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(_personView.frame.size.width-150, 31, 60, 17)];
    
    self.womanweatherLabel.textAlignment = NSTextAlignmentRight;
    
    self.womanweatherLabel.font = FONT(12);
    
    self.womanweatherLabel.text = @"晴";
    
    self.womanweatherLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.womanweatherLabel];
    
    self.womantempLabel = [[UILabel alloc]initWithFrame:CGRectMake(_personView.frame.size.width-85, 31, 30, 17)];
    
    self.womantempLabel.textAlignment = NSTextAlignmentRight;
    
    self.womantempLabel.font = FONT(12);
    
    self.womantempLabel.text = @"22℃";
    
    self.womantempLabel.textColor = [UIColor whiteColor];
    
    [self.personView addSubview:self.womantempLabel];
    
    //    menuView
    
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(0, _middleView.frame.size.height-105, WIDTH, 105)];
    
    self.menuView.backgroundColor = COLOR(255, 255, 255, 0.4);
    
    [self.middleView addSubview:self.menuView];
    
    self.sharkBtn = [[UIButton alloc]initWithFrame:CGRectMake(_menuView.frame.size.width/4-25, 15, 50, 50)];
    
    self.sharkBtn.layer.cornerRadius = 25;
    
    self.sharkBtn.layer.masksToBounds = YES;
    
    self.sharkBtn.layer.borderWidth = 1;
    
    self.sharkBtn.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    
    [self.sharkBtn setImage:[UIImage imageNamed:@"shark.png"] forState:UIControlStateNormal];
    
    [self.sharkBtn addTarget:self action:@selector(shark) forControlEvents:UIControlEventTouchUpInside];
    
    [self.menuView addSubview:self.sharkBtn];
    
    
    self.sharkLabel = [[UILabel alloc]initWithFrame:CGRectMake(_menuView.frame.size.width/4-25, 75, 50, 17)];
    
    self.sharkLabel.text = @"摇一摇";
    
    self.sharkLabel.textAlignment = NSTextAlignmentCenter;
    
    self.sharkLabel.font = FONT(13);
    
    self.sharkLabel.textColor = [UIColor whiteColor];
    
    
    
    [self.menuView addSubview:self.sharkLabel];
    
    
    //
    self.chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(_menuView.frame.size.width/2-25, 15, 50, 50)];
    
    self.chatBtn.layer.cornerRadius = 25;
    
    self.chatBtn.layer.masksToBounds = YES;
    
    self.chatBtn.layer.borderWidth = 1;
    
    self.chatBtn.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    
    [self.chatBtn setImage:[UIImage imageNamed:@"Chat.png"] forState:UIControlStateNormal];
    
    [self.menuView addSubview:self.chatBtn];
    
    [self.chatBtn addTarget:self action:@selector(lovechat) forControlEvents:UIControlEventTouchDown];
    
    self.chatLabel = [[UILabel alloc]initWithFrame:CGRectMake(_menuView.frame.size.width/2-25, 75, 50, 17)];
    
    self.chatLabel.text = @"聊天";
    
    self.chatLabel.textAlignment = NSTextAlignmentCenter;
    
    self.chatLabel.font = FONT(13);
    
    self.chatLabel.textColor = [UIColor whiteColor];
    
    [self.menuView addSubview:self.chatLabel];
    //
    self.memorialBtn = [[UIButton alloc]initWithFrame:CGRectMake((_menuView.frame.size.width)*3/4-25, 15, 50, 50)];
    
    self.memorialBtn.layer.cornerRadius = 25;
    
    self.memorialBtn.layer.masksToBounds = YES;
    
    self.memorialBtn.layer.borderWidth = 1;
    
    self.memorialBtn.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    
    [self.memorialBtn setImage:[UIImage imageNamed:@"memorial.png"] forState:UIControlStateNormal];
    
    [self.menuView addSubview:self.memorialBtn];
    
    [self.memorialBtn addTarget:self action:@selector(memorialDay) forControlEvents:UIControlEventTouchDown];
    
    self.memorialLabel= [[UILabel alloc]initWithFrame:CGRectMake((_menuView.frame.size.width)*3/4-25, 75, 50, 17)];
    
    self.memorialLabel.text = @"纪念日";
    
    self.memorialLabel.textAlignment = NSTextAlignmentCenter;
    
    self.memorialLabel.font = FONT(13);
    
    self.memorialLabel.textColor = [UIColor whiteColor];
    
    [self.menuView addSubview:self.memorialLabel];
    
    //plist
    
    PlistLocalInfo *Info = [[PlistLocalInfo alloc]init];
    
    NSString  *infoPath = [Info userInfoPath];
    
    self.lastPath = [infoPath stringByAppendingFormat:@"test1.png"];
    //开启定位
    [self startLocation];
    
    //天气请求
    
    NSString *city = [_cityNameStr substringToIndex:2];
    NSLog(@"%@",city);
    
    //    weatherServices *data = [[weatherServices alloc]init];
    //    [data weatherData:_mancityLabel.text addWithSucess:^(NSDictionary *dic) {
    //
    //        self.weatherMutDic = [[[dic objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"realtime"];
    //
    //        self.mantempLabel.text = [self.weatherMutDic objectForKey:@"temperature"];
    //         self.manweatherLabel.text = [self.weatherMutDic objectForKey:@"info"];
    ////        self.label2.text = [[self.mutdic objectForKey:@"weather"] objectForKey:@"temperature"];
    //
    //    } addWithEror:^(NSString *str) {
    //        NSLog(@"%@", str);
    //    }];
}






- (void)photo:(UIButton *)sender{
    //1.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //2.
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self locaPhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //3.
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    //4.
    [self presentViewController:alert animated:YES completion:nil];
}

//调出本地相册
- (void)locaPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker  animated:YES completion:nil];
    }
}
//调出摄像头
- (void)camera{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取沙盒路径
    self.DocumentsPath = [[NSHomeDirectory() stringByAppendingString:@"/documents"] stringByAppendingString:@"/bgimage.png"];
    //把图片直接保存到指定的路径
    [UIImagePNGRepresentation(image) writeToFile:_DocumentsPath atomically:YES];
    NSLog(@"%@", _DocumentsPath);
    self.middleImage.image = [UIImage imageWithContentsOfFile:_DocumentsPath];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ////    保存图片至本地
    //    NSData *data;
    //    if (UIImagePNGRepresentation(image)) {
    //        data = UIImageJPEGRepresentation(image, 1.0);
    //    }else{
    //        data = UIImagePNGRepresentation(image);
    //    }
    //
    //
    //
    //
    //
    //    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"test.png"];
    //
    //    [data writeToFile:fullPath atomically:YES];
    //
    //    UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    //    self.middleImage.image = savedImage;
    
    //
    //    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //    if ([type isEqualToString:@"public.image"]) {
    //
    //        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //
    //        NSDictionary *dic = [[NSDictionary alloc]init];
    //        [dic writeToFile:_lastPath atomically:YES];
    //
    //
    ////        [UIImagePNGRepresentation(image) writeToFile:_lastPath atomically:YES];
    //
    //        [picker dismissViewControllerAnimated:YES completion:nil];
    //        NSLog(@"%@",_lastPath);
    //            UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:_lastPath];
    //        self.middleImage.image = savedImage;
    //    }
    
    
    //    NSLog(@"%@",fullPath);
    //    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //    if ([type isEqualToString:@"public.image"]) {
    //
    //        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //
    //                NSDictionary *dic = [[NSDictionary alloc]init];
    //                [dic writeToFile:_lastPath atomically:YES];
    //
    //        [UIImagePNGRepresentation(image) writeToFile:_lastPath atomically:YES];
    //
    //        [picker dismissViewControllerAnimated:YES completion:nil];
    //        NSLog(@"%@",_lastPath);
    //    }
    
    //    [picker dismissViewControllerAnimated:YES completion:nil];
}


/*
 -(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
 [picker dismissViewControllerAnimated:YES completion:^{
 
 }];
 
 if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]) {
 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
 
 
 [alert show];
 }else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeImage]) {
 
 UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
 
 //        图片太大，压缩上传
 
 UIImage *miniImage = [self scaleImage:originImage toScale:0.3];
 
 NSData *data = UIImagePNGRepresentation(miniImage);
 
 //将二进制数据生成UIImage
 //        UIImage *image = [UIImage imageWithData:data];
 
 //        为保证图片质量 可以上传原图
 
 
 UIImage *scaleImage = [self scaleImage:originImage toScale:0.7];
 
 NSData *scaledata = UIImagePNGRepresentation(scaleImage);
 
 //图片保存的路径
 //这里将图片放在沙盒的documents文件夹中
 
 self.paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
 
 
 self.DocumentsPath = [_paths objectAtIndex:0];//[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 
 //文件管理器
 _fileManager = [NSFileManager defaultManager];
 
 //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
 [_fileManager createDirectoryAtPath:_DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
 [_fileManager createFileAtPath:[_DocumentsPath stringByAppendingPathComponent:@"image.png"] contents:data attributes:nil];
 [_fileManager createFileAtPath:[_DocumentsPath stringByAppendingPathComponent:@"originimage.png"] contents:scaledata attributes:nil];
 //得到选择后沙盒中图片的完整路径
 
 _imagePath = [_DocumentsPath stringByAppendingPathComponent:@"image.png"];
 _originimagePath=[_DocumentsPath stringByAppendingPathComponent:@"originimage.png"];
 
 NSUserDefaults *path = [NSUserDefaults standardUserDefaults];
 
 [path setObject: _imagePath forKey:@"pic"];
 
 [path setObject: _originimagePath forKey:@"originpic"];
 
 
 self.middleImage.image=[UIImage imageWithContentsOfFile:_imagePath];
 //        delBtn.hidden=NO;
 }
 [picker dismissViewControllerAnimated:YES completion:^{
 
 }];
 }
 
 #pragma mark- 缩放图片
 -(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
 {
 UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
 [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
 UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return scaledImage;
 }
 
 -(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 
 [picker dismissViewControllerAnimated:YES completion:^{
 
 }];
 }
 */
//定位
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


//开始定位
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

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [_locationManager stopUpdatingLocation];
        
        
        NSLog(@"location ok");
        
        NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                
                NSDictionary *test = [placemark addressDictionary];
                //  Country(国家)  State(城市)  SubLocality(区)
                
                NSLog(@"City---%@", [test objectForKey:@"City"]);
                
                self.cityNameStr = [test objectForKey:@"City"];
                
                self.mancityLabel.text = self.cityNameStr;
                
                
                NSLog(@"%@",test);
                
                self.subLocality = [test objectForKey:@"SubLocality"];
                NSLog(@"%@",self.subLocality);
                
                
                
            }
            //天气请求
            
            NSString *city = [_cityNameStr substringToIndex:2];
            NSLog(@">>>%@",city);
            
            weatherServices *data = [[weatherServices alloc]init];
            [data weatherData:city addWithSucess:^(NSDictionary *dic) {
                //                NSLog(@">>>dic%@",dic);
                self.weatherMutDic = [[[[dic objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"realtime"]objectForKey:@"weather"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.mantempLabel.text = [NSString stringWithFormat:@"%@℃",[self.weatherMutDic objectForKey:@"temperature"]];
                    
                    self.manweatherLabel.text = [self.weatherMutDic objectForKey:@"info"];
                    
                });
            } addWithEror:^(NSString *str) {
                //                NSLog(@"%@", str);
            }];
            
        }];
        
    });
    
    
    
}

//摇一摇跳转
-(void)shark{
    SharkViewController *loveshark = [[SharkViewController alloc]init];
    
    loveshark.city = self.cityNameStr;
    loveshark.detaladress = self.subLocality;
    
    //隐藏底部tabbar
    loveshark.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:loveshark animated:YES];
}
//聊天跳转
-(void)lovechat{
    //新建一个聊天会话View Controller对象
    chatViewController *chat = [[chatViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = 1;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"7777";
    //设置聊天会话界面要显示的标题
    chat.title = @"聊天";
    //隐藏底部tabbar
    chat.hidesBottomBarWhenPushed = YES;
    //显示聊天会话界面
    
    [self.navigationController pushViewController:chat animated:YES];
    
    
    //    [self presentViewController:chat animated:YES completion:nil];
}
//纪念日跳转
-(void)memorialDay{
    memorialViewController *mday = [[memorialViewController alloc]init];
    
    //隐藏底部tabbar
    mday.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mday animated:YES];
}

@end