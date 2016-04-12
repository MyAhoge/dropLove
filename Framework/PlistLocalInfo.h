//
//  PlistLocalInfo.h
//  test_plist
//
//  Created by Vic on 16/1/12.
//  Copyright © 2016年 Gem-inno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistLocalInfo : NSObject

@property (copy, nonatomic)NSString *rootPath;

- (NSString *)userInfoPath;

@end
