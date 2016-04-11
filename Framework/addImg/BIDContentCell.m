//
//  BIDContentCell.m
//  DialogViewer
//
//  Created by JN on 10/17/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDContentCell.h"

@implementation BIDContentCell

- (void)awakeFromNib {
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  <#Description#>
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.MyImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.MyImageView];
        
        self.selectedImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.selectedImageView];
    }
    return self;
}

@end
