//
//  ZWNewfeatureViewController.m
//  Weibo
//
//  Created by qianfeng on 15/4/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWNewfeatureViewController.h"
#import "ZWTabBarController.h"

#define ZWNewfeatureImageCount 3

@interface ZWNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation ZWNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加UIScrollView
    [self setupScrollView];
    
    //2.添加pageControl
    [self setupPageControl];
}

/**
 *  添加pageControl
 */
- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZWNewfeatureImageCount;
    CGFloat centerX = CGRectGetWidth(self.view.frame) * 0.5;
    CGFloat centerY = CGRectGetHeight(self.view.frame) - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.currentPageIndicatorTintColor = ZWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = ZWColor(189, 189, 189);
}


/**
 *  添加UIScrollView
 */
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //添加图片
    CGFloat imageW = CGRectGetWidth(scrollView.frame);
    CGFloat imageH = CGRectGetHeight(scrollView.frame);
    for (int index = 0; index < ZWNewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index+1];
        imageView.image = [UIImage imageWithName:name];
        
        CGFloat imageX = index*imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];

        //在最后一个图片上面添加一个按钮
        if (index == ZWNewfeatureImageCount-1) {
            [self setupLastImageView:imageView];
        }
        
        //设置滚动的内容内容尺寸
        scrollView.contentSize = CGSizeMake(imageW * ZWNewfeatureImageCount, 0);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
    }
}

/**
 *  添加内容到最后一张图片
 *
 *  @param imageView 最后一个ImageView
 */
- (void)setupLastImageView:(UIImageView *)imageView {
    //让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    //添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    //设置frame
    CGFloat centerX = CGRectGetWidth(imageView.frame) * 0.5;
    CGFloat centerY = CGRectGetHeight(imageView.frame) * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    //设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
    //添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = CGRectGetHeight(imageView.frame) * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkbox];
}

/**
 *  开始微博
 */
- (void)start {
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[ZWTabBarController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox {
    checkbox.selected = !checkbox.isSelected;
}

/**
 *  只要UIScrollView滚动了就会调用
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //求出页码
    double pageDouble = offsetX / CGRectGetWidth(scrollView.frame);
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
