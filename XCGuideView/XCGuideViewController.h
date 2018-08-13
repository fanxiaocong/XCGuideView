//
//  XCGuideViewController.h
//  XCGuideViewExample
//
//  Created by 樊小聪 on 2018/8/13.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCGuideViewController : UICollectionViewController

/// 图片数据
@property (strong, nonatomic) NSArray<UIImage *> *images;

/// 点击 跳过 按钮的回调
@property (copy, nonatomic) void(^didClickSkipActionCallBack)(UIViewController *vc);
/// 点击 立即体验 按钮的回调
@property (copy, nonatomic) void(^didClickGotoActionCallBack)(UIViewController *vc);

/// 更新 按钮的 UI
- (void)updateButtonsConfigure:(void(^)(UIButton *skipButton, UIButton *gotoButton))config;

@end
