//
//  PSInfoTableViewCell.m
//  dropLove
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 ljz. All rights reserved.
//

#import "PSInfoTableViewCell.h"
#import "dropHeader.h"

@implementation PSInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.namelab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 60, 20)];
        self.namelab.font = FONT(15);
        self.namelab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_namelab];
        
        //        self.textname = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, WIDTH_MY-80-15-10-10, 20)];
        //        self.textname.font = FONT(15);
        //        self.textname.textAlignment = NSTextAlignmentRight;
        //        self.textname.keyboardType = UIControlStateNormal;
        //        self.textname.returnKeyType = UIReturnKeyDone;
        //        self.textname.clearButtonMode =  UITextFieldViewModeWhileEditing;
        //        [self.contentView addSubview:_textname];
        //        [self.textname addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        self.textname1 = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, WIDTH_MY-80-15-10-10, 20)];
        self.textname1.font = FONT(15);
        self.textname1.textAlignment = NSTextAlignmentRight;
        self.textname1.keyboardType = UIControlStateNormal;
        self.textname1.returnKeyType = UIReturnKeyDone;
        self.textname1.clearButtonMode =  UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textname1];
        [self.textname1 addTarget:self action:@selector(backgroundTap1) forControlEvents:UIControlEventEditingDidEndOnExit];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}



- (void)backgroundTap1{
    
    NSLog(@"4321");
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject: self.textname1.text forKey:@"pstextname1"];
    [defaults synchronize];
    
    NSLog(@"%@", self.textname1.text);
    
    NSDictionary *namedd = [[NSDictionary alloc]init];
    namedd = @{@"nname":self.textname1.text,
               @"id":@1};
    NSLog(@"修改的昵称******%@",self.textname1.text);
    
    

    
    [IcomNSObject name:namedd Andicomchange:^(NSDictionary *name) {
        NSLog(@"修改成功");
    }];
    
    
}


@end