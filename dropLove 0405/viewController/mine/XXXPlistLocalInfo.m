//
//  XXXPlistLocalInfo.m
//  test_plist
//
//  Created by Vic on 16/1/12.
//  Copyright © 2016年 Gem-inno. All rights reserved.
//

#import "XXXPlistLocalInfo.h"

@implementation XXXPlistLocalInfo


- (instancetype)init{
    if (self = [super init]) {
        NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
       
        self.rootPath = [[pathArr objectAtIndex:0]stringByAppendingPathComponent:@"XXXPlist"];
        
        if ([[NSFileManager defaultManager]fileExistsAtPath:_rootPath] == NO) {
            if (![[NSFileManager defaultManager]createDirectoryAtPath:_rootPath withIntermediateDirectories:NO attributes:nil error:nil]) {
                
            }
        }
    }
    return self;
}

- (BOOL)createDirectory:(NSString *)path{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil]) {
            
            return NO;
            
        }
    }
    return YES;
}

- (NSString *)userInfoPath {
    //    NSString *path = [_rootPath stringByAppendingPathComponent:@"LoginInfo.plist"];
    if ([self createDirectory:_rootPath]) {
        return _rootPath;
    }
    return nil;
}

@end
