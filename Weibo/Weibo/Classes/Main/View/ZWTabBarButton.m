//
//  ZWTabBarButton.m
//  Weibo
//
//  Created by qianfeng on 15/4/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

//图标的比例
#define ZWTabBarButtonImageRatio 0.6
//按钮的默认文字颜色
#define ZWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
//按钮的选中文字颜色
#define ZWTabBarButtonTitleSelectedColor (iOS7 ? ZWColor(234, 103, 7) : ZWColor(248, 139, 0))

#import "ZWTabBarButton.h"
#import "ZWBadgeButton.h"

@interface ZWTabBarButton ()

//提醒数字
@property (nonatomic, weak) ZWBadgeButton *badgeButton;
@end

@implementation ZWTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:ZWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:ZWTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        ZWBadgeButton *badgeButton = [[ZWBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = CGRectGetHeight(contentRect)*ZWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = CGRectGetHeight(contentRect)*ZWTabBarButtonImageRatio;
    
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect)-titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    
    //KVO监听属性的改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    //设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width-self.badgeButton.frame.size.width-10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

@end
