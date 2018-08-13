//
//  XCGuideViewController.m
//  XCGuideViewExample
//
//  Created by 樊小聪 on 2018/8/13.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import "XCGuideViewController.h"
#import "XCGuideCell.h"
#import <XCMacros/XCMacros.h>

@interface XCGuideViewController ()

@property (weak, nonatomic) UIButton *skipButton;
@property (weak, nonatomic) UIButton *gotoButton;
@property (weak, nonatomic) UIPageControl *pageCtl;

@end

@implementation XCGuideViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 🔓 👀 Public Method 👀

- (void)updateButtonsConfigure:(void (^)(UIButton *, UIButton *))config
{
    if (config) {
        config(self.skipButton, self.gotoButton);
    }
}

#pragma mark - ⏳ 👀 LifeCycle Method 👀

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 设置行距
    layout.minimumLineSpacing = 0;
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// 设置 UI
    [self setupUI];
}

#pragma mark - ✏️ 🖼 SetupUI Method 🖼

- (void)setupUI
{
    /// 设置 collectView
    [self setupCollectView];
    /// 设置 跳过按钮
    [self setupSkitButton];
    /// 设置 立即体验按钮
    [self setupGoToButton];
    /// 设置 pageControl
    [self setupPageControl];
}

/**
 *  设置 collectView
 */
- (void)setupCollectView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[XCGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

/**
 *  设置 跳过按钮
 */
- (void)setupSkitButton
{
    CGFloat margin = 15;
    CGFloat skipButtonWH = 40;
    CGFloat skipButtonX  = SCREEN_WIDTH - skipButtonWH - margin;
    CGFloat skipButtonY  = margin + STARTUS_BAR_HEIGHT;
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _skipButton = skipButton;
    
    skipButton.frame = CGRectMake(skipButtonX , skipButtonY, skipButtonWH, skipButtonWH);
    
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    skipButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2f];
    [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    skipButton.titleLabel.font     = [UIFont systemFontOfSize:10];
    skipButton.layer.cornerRadius  = skipButtonWH * 0.5;
    skipButton.layer.borderColor   = [UIColor whiteColor].CGColor;
    skipButton.layer.borderWidth   = .5f;
    skipButton.layer.masksToBounds = YES;
    [skipButton addTarget:self action:@selector(didClickSkipButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:skipButton];
}

/**
 *  设置 立即体验按钮
 */
- (void)setupGoToButton
{
    UIButton *gotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _gotoButton = gotoButton;
    
    CGFloat w = 125;
    CGFloat h = 40;
    CGFloat y = SCREEN_HEIGHT - 100;
    CGFloat x = SCREEN_WIDTH * (self.images.count - 0.5) - w * 0.5;
    gotoButton.frame = CGRectMake(x, y, w, h);

    [gotoButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.2f]];
    [gotoButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [gotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gotoButton.titleLabel.font     = [UIFont systemFontOfSize:15];
    gotoButton.layer.cornerRadius  = 2;
    gotoButton.layer.borderColor   = [UIColor whiteColor].CGColor;
    gotoButton.layer.borderWidth   = .5f;
    gotoButton.layer.masksToBounds = YES;
    [gotoButton addTarget:self action:@selector(didClickGotoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:gotoButton];
}

/**
 *  设置 pageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageCtl = [[UIPageControl alloc] init];
    _pageCtl = pageCtl;
    pageCtl.numberOfPages = self.images.count;
    pageCtl.hidesForSinglePage = YES;
    pageCtl.backgroundColor = [UIColor lightGrayColor];
    pageCtl.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 25);
    [self.view addSubview:pageCtl];
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击 跳过按钮 的回调
 */
- (void)didClickSkipButtonAction
{
    if (self.didClickSkipActionCallBack) {
        self.didClickSkipActionCallBack(self);
    }
}

/**
 *  点击 立即体验 按钮的回调
 */
- (void)didClickGotoButtonAction
{
    if (self.didClickGotoActionCallBack) {
        self.didClickGotoActionCallBack(self);
    }
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.images.count > indexPath.item) {
        cell.imageView.image = self.images[indexPath.item];
    }
    
    return cell;
}

#pragma mark - UIScrollView代理

// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取当前的偏移量，计算当前第几页
    NSInteger page = offsetX / scrollView.bounds.size.width + 0.5;
    // 设置页数
    _pageCtl.currentPage = page;
    
    /// 更新 gotoButton 的位置
    CGRect f = self.gotoButton.frame;
    f.origin.x = SCREEN_WIDTH * (self.images.count - 0.5) - f.size.width * 0.5 - offsetX;
    self.gotoButton.frame = f;
}


@end
