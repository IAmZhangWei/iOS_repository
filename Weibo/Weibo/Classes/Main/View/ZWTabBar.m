//
//  ZWTabBar.m
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWTabBar.h"
#import "ZWTabBarButton.h"

@interface ZWTabBar ()
@property(nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) ZWTabBarButton *selectedBtn;

@end

@implementation ZWTabBar

- (void)dealloc
{
    [self.tabBarButtons removeAllObjects];
    self.tabBarButtons = nil;
    self.plusButton = nil;
    self.selectedBtn = nil;
}

- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [[NSMutableArray alloc] init];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        //添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    //创建按钮
    ZWTabBarButton *button = [[ZWTabBarButton alloc] init];
    [self addSubview:button];
    
    //添加按钮到数据中
    [self.tabBarButtons addObject:button];
    
    //设置数据
    button.item = item; 
    
    //监听按钮点击
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    
    //默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClicked:button];
    }
}

- (void)buttonClicked:(ZWTabBarButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedBtn.tag to:(int)button.tag];
    }

    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
    
    //按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w/self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        //取出按钮
        ZWTabBarButton *button = self.tabBarButtons[index];
        
        //设置按钮的frame
        CGFloat buttonX = index*buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = index;
    }
}

@end
