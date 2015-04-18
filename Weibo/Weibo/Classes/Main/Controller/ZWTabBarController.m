//
//  ZWTabBarController.m
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWTabBarController.h"

#import "ZWHomeViewController.h"
#import "ZWMessageViewController.h"
#import "ZWMeViewController.h"
#import "ZWDiscoverViewController.h"
#import "ZWTabBar.h"

@interface ZWTabBarController ()<ZWTabBarDelegate>

@property (nonatomic, weak) ZWTabBar *customTabBar;
@end

@implementation ZWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabbar
    [self setUpTabbar];
    
    //初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)setUpTabbar {
    ZWTabBar *customTabBar = [[ZWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}

- (void)setupAllChildViewControllers {
    //1.首页
    ZWHomeViewController *home = [[ZWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //2.消息
    ZWMessageViewController *message = [[ZWMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    //3.广场
    ZWDiscoverViewController *discover = [[ZWDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    //4.我
    ZWMeViewController *me = [[ZWMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}


- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childVC.title = title;
    childVC.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    childVC.tabBarItem.image = [UIImage imageWithName:imageName];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    
    //包装一个导航控制器
    [self addChildViewController:nav];
    //3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
}

@end