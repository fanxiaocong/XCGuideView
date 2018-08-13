//
//  XCGuideCell.m
//  XCGuideViewExample
//
//  Created by 樊小聪 on 2018/8/13.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import "XCGuideCell.h"

@implementation XCGuideCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        _imageView = imgView;
        [self addSubview:imgView];
    }
    return _imageView;
}

@end
