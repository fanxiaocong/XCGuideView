//
//  ViewController.m
//  XCGuideViewExample
//
//  Created by 樊小聪 on 2018/8/13.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import "ViewController.h"
#import "XCGuideViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickShowButtonAction:(id)sender
{
    XCGuideViewController *vc = [[XCGuideViewController alloc] init];
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i ++) {
        NSString *imgName = [NSString stringWithFormat:@"guide_%zi", i];
        UIImage *image = [UIImage imageNamed:imgName];
        [mArr addObject:image];
    }
    vc.images = mArr;
    vc.didClickSkipActionCallBack = ^(UIViewController *vc) {
        NSLog(@"*** 跳过 ***");
    };
    vc.didClickGotoActionCallBack = ^(UIViewController *vc) {
        NSLog(@"*** 立即体验 ***");
    };
    [vc updateButtonsConfigure:^(UIButton *skipButton, UIButton *gotoButton) {
        
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
