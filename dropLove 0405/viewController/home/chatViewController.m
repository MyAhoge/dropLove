//
//  chatViewController.m
//  dropLove
//
//  Created by Mayday_xy on 16/3/31.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "chatViewController.h"
#import "dropHeader.h"
@interface chatViewController ()

@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//        self.changbgBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40, 30, 25, 25)];
//    
//        [self.changbgBtn setImage:[UIImage imageNamed:@"112.png"] forState:UIControlStateNormal];
//    
//        [self.changbgBtn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
//    
//        [self.view addSubview:self.changbgBtn];
//
    self.conversationMessageCollectionView.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    
    //1.创建UIBarButtonItem对象
    UIBarButtonItem *rightBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemCamera target:self action:@selector(photo:)];
    
    //2.把UIBarButtonItem对象赋值给leftBarButtonItem或者rightBarButtonItem
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
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
    self.conversationMessageCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:_DocumentsPath]];


    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
