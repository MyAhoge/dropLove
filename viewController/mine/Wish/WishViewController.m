//
//  WishViewController.m
//  dropLove
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "WishViewController.h"
#import "dropHeader.h"


@interface WishViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic)NSArray *arrwish;

@property (strong, nonatomic)NSMutableArray *mutarrwish;

@property (assign, nonatomic)int k;

@property (copy, nonatomic) NSString *localpath;

@property (copy, nonatomic) NSString *lastpath;

@property (strong, nonatomic) NSDictionary *dic;

@property (strong, nonatomic)NSMutableDictionary *mutdic;

@property (strong, nonatomic)UIView *addview;

@property (strong, nonatomic)UIView *view1;

@property (strong, nonatomic)UIView *view2;

@property (strong, nonatomic)UITextView *textView;

@property (strong, nonatomic)UILabel *lable1;

@property (strong, nonatomic)UIImageView *image1;

@property (strong, nonatomic)UIImageView *image2;

@property (strong, nonatomic)UIImageView *image3;

@property (strong, nonatomic)UIImageView *image4;

@property (strong, nonatomic)NSMutableArray *array;

@property (copy, nonatomic)NSString *cityplace;

@property (copy, nonatomic)NSString *deldewish8;

@property (strong, nonatomic)UIScrollView *imageScroll;

@end

@implementation WishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"=======%@",_citysub);
    
    
    
    self.mutarrwish = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor =COLOR(243, 239, 230, 1);
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    self.title = @"我们的愿望";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    //1.创建UIBarButtonItem对象
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addwish)];
    
    //2.把UIBarButtonItem对象赋值给leftBarButtonItem或者rightBarButtonItem
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY-64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_table];
    self.table.sectionHeaderHeight = 5;
    self.table.sectionFooterHeight = 5;
    self.table.delegate = self;
    self.table.dataSource =self;
    
    
    /**
     添加愿望界面
     */
    self.addview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY)];
    self.addview.backgroundColor = COLOR(243, 239, 230, 1);
    [self.view addSubview:_addview];
    
    
    
    /**
     添加愿望写汉字页面
     */
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_MY, (WIDTH_MY-30-10)/3+200+40-50-50-10)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.addview addSubview:_view1];
    
    
    //  编辑愿望内容
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(15, 5, WIDTH_MY-30, 100)]; //初始化大小
    self.textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.textView.font = [UIFont systemFontOfSize:15];//设置字体名字和字体大小
    self.textView.delegate = self;//设置它的委托方法
    self.textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textView.scrollEnabled = YES;//是否可以拖动
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view1 addSubview: self.textView];//加入到整个页面中
    
    //  提示文字
    self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 13, 120, 15)];
    self.lable1.textColor = [UIColor grayColor];
    self.lable1.font = FONT(15);
    self.lable1.text = @"记录一下愿望吧...";
    self.lable1.textAlignment = NSTextAlignmentLeft;
    [self.view1 addSubview:_lable1];
    
    // 添加图片按钮
    
    self.image4 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    [self.view1 addSubview:_image4];
    
    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    self.image1.image = [UIImage imageNamed:@"101.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picture)];
    self.image1.userInteractionEnabled = YES;
    [self.image1 addGestureRecognizer:tap];
    [self.view1 addSubview:_image1];
    
    self.image2 = [[UIImageView alloc]initWithFrame:CGRectMake(15+(WIDTH_MY-30-10)/3+5, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    [self.view1 addSubview:_image2];
    
    self.image3 = [[UIImageView alloc]initWithFrame:CGRectMake(15+(WIDTH_MY-30-10)/3*2+10, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3)];
    [self.view1 addSubview:_image3];
    
    
    
    
    /**
     添加愿望地点选项
     */
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0,(WIDTH_MY-30-10)/3+200+40-50-50-10+10 , WIDTH_MY, 40)];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.addview addSubview:_view2];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 30, 20)];
    lable3.font = FONT(13);
    lable3.text = @"地点";
    lable3.textColor = [UIColor blackColor];
    [self.view2 addSubview:lable3];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_MY-25-5, 12.5, 20, 15)];
    image2.image = [UIImage imageNamed:@"下一页"];
    [self.view2 addSubview:image2];
    
    [self downline];
}


/**
 *  加载数据库中的愿望
 */
- (void)downline{
    // CGD 线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [IcomNSObject wish:^(NSDictionary *wishdic) {
            //                        NSLog(@"%@",wishdic);
            self.arrwish  = [wishdic objectForKey:@"data"];
            //            NSLog(@"=========%@",self.arrwish);
            
            if (self.arrwish != nil && ![self.arrwish isKindOfClass:[NSNull class]] && self.arrwish.count != 0){
                
                NSLog(@"1233");
                
                
                for (NSDictionary *date1 in self.arrwish) {
                    
                    ClockModel *model = [[ClockModel alloc]init];
                    //                NSLog(@"%@",date1);
                    NSLog(@"%@",[date1 objectForKey:@"wish_content"]);
                    model.content = [date1 objectForKey:@"wish_content"];
                    model.date = [date1 objectForKey:@"wish_date"];
                    model.place = [date1 objectForKey:@"wish_place"];
                    model.image = [date1 objectForKey:@"wish_image"];
                    model.wishid = [date1 objectForKey:@"wish_id"];
                    NSLog(@"=========%@======",[date1 objectForKey:@"wish_id"]);
                    [self.mutarrwish addObject:model];
                    
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
            
        }];
    });
    
    
}


/**
 *  添加愿望图片按钮弹出选项
 */
- (void)picture{
    
    NSLog(@"添加照片");
    
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
    
    //NSLog(@"相册");
    //    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    [self presentViewController:picker animated:YES completion:nil];
    
    
    
    
    
}
//调出摄像头
- (void)camera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    
    
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}




// 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if (self.image4.image == nil) {
        [self.image4 setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        self.image1.frame = CGRectMake(15+(WIDTH_MY-30-10)/3+5, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3);
    }else if(self.image2.image == nil){
        
        [self.image2 setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        self.image1.frame = CGRectMake(15+(WIDTH_MY-30-10)/3*2+10, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3);
    }else if(self.image3.image == nil){
        
        [self.image3 setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        self.image1.frame = CGRectMake(1000, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3);
        
    }
    NSLog(@"++++++--------%@",self.image2.image);
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",info);
    
    
    
    
    
    
    //创建可变数组,存储资源文件
    self.array = [NSMutableArray arrayWithCapacity:0];
    
    //创建资源库,用于访问相册资源
    
    
    //    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //
    //    //遍历资源库中所有的相册,有多少个相册,usingBlock会调用多少次
    //    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
    //
    //        //如果存在相册,再遍历
    //        if (group) {
    //
    //            //遍历相册中所有的资源(照片,视频)
    //            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
    //
    //                if (result) {
    //                    //将资源存储到数组中
    //                    [_array addObject:result];
    //
    //                }
    //            }];
    //        }
    
    //刷新_collectionView reloadData;
    //        [_collect reloadData];
    //
    //    } failureBlock:^(NSError *error) {
    //
    //        NSLog(@"访问失败");
    //    }];
    
    NSLog(@"%@",_array);
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    NSLog(@"++++组数++++%lu",(unsigned long)self.arrwish.count);
    return self.mutarrwish.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _height;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    WishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    ClockModel *model = [[ClockModel alloc]init];
    model = self.mutarrwish[self.mutarrwish.count-1-indexPath.section];
    cell.contentlab.text = model.content;
    cell.datelab.text = model.date;
    cell.placelab.text = model.place;
    
    NSLog(@"%@",model.wishid);
    
    
    
    NSString *image1 = model.image;
    if (image1 != nil) {
        cell.image.image = [UIImage imageNamed:@"丽江.jpg"];
        cell.image2.image = [UIImage imageNamed:@"风景11.jpg"];
        cell.image3.image = [UIImage imageNamed:@"风景10.jpg"];
    }
    
    [cell setHeight:cell.contentlab.text];
    self.height = cell.frame.size.height;
    
    [cell.deletebtn addTarget:self action:@selector(delete5:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletebtn.tag = self.mutarrwish.count-1-indexPath.section+500;
    
    
    return cell;
    
}


/**
 *  删除愿望
 *
 */
- (void)delete5:(UIButton *)sender{
    
    NSLog(@"%ld",(long)sender.tag);
    
    NSLog(@"*****************%@",(ClockModel *)[self.mutarrwish[sender.tag-500] wishid]);
    
    UIAlertController *acl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *aat = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        /**
         *  这个必须在前面 （先删除数据库里的数据再删除数组中的数据）
         */
        if ((ClockModel *)[self.mutarrwish[sender.tag-500] wishid] != NULL) {
            
            NSDictionary *deldedic = @{@"nwish":(ClockModel *)[self.mutarrwish[sender.tag-500] wishid],
                                       @"id":@1};
            [IcomNSObject deletewish:deldedic Andicomchange:^(NSDictionary *signature) {
                NSLog(@"删除成功");
            }];
        }
        
        
        
        /**
         *  这个必须再后面
         */
        [self.mutarrwish removeObjectAtIndex:sender.tag-500];
        NSLog(@"%@",_mutarrwish);
        [self.table reloadData];
        NSLog(@"-----------------%ld",sender.tag);
        
    }];
    
    
    UIAlertAction *aat2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [acl addAction:aat];
    [acl addAction:aat2];
    [self presentViewController:acl animated:YES completion:nil];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//  进入添加愿望
- (void)addwish{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.table setHidden:NO];
        self.addview.frame = CGRectMake(0, 0, WIDTH_MY, HEIGHT_MY);
        
        self.title = @"添加愿望";
        
        
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style: UIBarButtonItemStylePlain target:self action:@selector(save)];
        
        
        rightBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightBtn;
        
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style: UIBarButtonItemStylePlain target:self action:@selector(cancle)];
        
        leftBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = leftBtn;
        
        
    }];
    
    
    
    
    NSLog(@"添加愿望");
    
    
}

/**
 *  添加愿望页面取消按钮
 */
- (void)cancle{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.table setHidden:NO];
        self.addview.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
        
        [self.view endEditing:YES];
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        self.mutdic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.title = @"我们的愿望";
        
        UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addwish)];
        
        rightBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightBtn;
        
        self.navigationItem.leftBarButtonItem = nil;
        
        self.image2.image = nil;
        self.image3.image = nil;
        self.image4.image = nil;
        self.image1.frame = CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3);
    }];
    
}

/**
 *  发布愿望
 */
- (void)save{
    
    NSLog(@"发布东西");
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([_textView.text length] == 0) {
            
            UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            UIAlertController *alertctl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入内容" preferredStyle:UIAlertControllerStyleAlert];
            [alertctl addAction:alert];
            [self presentViewController:alertctl animated:YES completion:nil];
            
            NSLog(@"请输入内容");
            
            
        }else{
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateStyle:NSDateFormatterFullStyle];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"++++添加时候的时间+++%@",dateString);
            
            
            
            if (self.citysub != nil) {
                self.cityplace = self.citysub;
                
            }else{
                self.cityplace = @"未知位置";
                
            }
            
            NSLog(@"+++愿望位置+++%@",self.cityplace);
            
            NSString *str = self.textView.text;
            
            NSMutableDictionary *mutdic1 = [[NSMutableDictionary alloc]initWithCapacity:0];
            int k = 1;
            NSString *kk = [NSString stringWithFormat:@"%d",k];
            [mutdic1 setValue:str forKey:@"content"];
            [mutdic1 setValue:self.cityplace forKey:@"place"];
            [mutdic1 setValue:dateString forKey:@"date"];
            [mutdic1 setObject:kk forKey:@"id"];
            [mutdic1 setObject:@"" forKey:@"image"];
            
            ClockModel *model = [[ClockModel alloc]init];
            model.content = str;
            model.date = dateString;
            model.place = self.cityplace;
            model.image = kk;
            [self.mutarrwish addObject:model];
            [self.table reloadData];
            
            [IcomNSObject addwish:mutdic1 Andaddwish:^(NSDictionary *dic) {
                NSLog(@"++++++添加成功");
            }];
            
            [self.table setHidden:NO];
            self.addview.frame = CGRectMake(0, HEIGHT_MY, WIDTH_MY, HEIGHT_MY);
            
            self.title = @"我们的愿望";
            
            UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addwish)];
            
            rightBtn.tintColor = [UIColor whiteColor];
            self.navigationItem.rightBarButtonItem = rightBtn;
            
            self.navigationItem.leftBarButtonItem = nil;
            
            self.image2.image = nil;
            self.image3.image = nil;
            self.image4.image = nil;
            self.image1.frame = CGRectMake(15, 200+15-50-50, (WIDTH_MY-30-10)/3, (WIDTH_MY-30-10)/3);
            
            
        }
        
        [self.view endEditing:YES];
        
        
    }];
    
    
}

/**
 *  点击键盘回收
 *
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

/**
 *  添加愿望提示文字框
 *
 */
- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        [self.lable1 setHidden:NO];
        
        
    }else{
        [self.lable1 setHidden:YES];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"123");
}

@end
