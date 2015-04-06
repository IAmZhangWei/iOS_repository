//
//  TabBarCon.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "TabBarCon.h"

#import "MainVC.h"
#import "GroupVC.h"
#import "DiscoveryVC.h"
#import "MineVC.h"

@interface TabBarCon ()

@end

@implementation TabBarCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"home_footbar_icon_dianping@3x"];
    UIImage *selectedImage = [UIImage imageNamed:@"home_footbar_icon_dianping_pressed@3x"];
    UINavigationController *mainNav = [self navigationControllerWithViewController:[MainVC class] title:nil image:image andSelectedImage:selectedImage];
    mainNav.title = @"首页";
    
    image = [UIImage imageNamed:@"home_footbar_icon_group@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_group_pressed@3x"];
    UINavigationController *groupNav = [self navigationControllerWithViewController:[GroupVC class] title:nil image:image andSelectedImage:selectedImage];
    groupNav.title = @"团购";
    
    image = [UIImage imageNamed:@"home_footbar_icon_found@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_found_pressed"];
    UINavigationController *discovNav = [self navigationControllerWithViewController:[DiscoveryVC class] title:nil image:image andSelectedImage:selectedImage];
    discovNav.title = @"发现";
    
    image = [UIImage imageNamed:@"home_footbar_icon_my@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_my_pressed@3x"];
    UINavigationController *mineNav = [self navigationControllerWithViewController:[MineVC class] title:@"我的" image:image andSelectedImage:selectedImage];
    
    self.viewControllers = @[mainNav, groupNav, discovNav, mineNav];
    self.tabBar.tintColor = [UIColor orangeColor];

}

- (UINavigationController *)navigationControllerWithViewController:(Class)VC  title:(NSString *)title image:(UIImage *)image andSelectedImage:(UIImage *)selectedImage {
    
    UIViewController *viewController = [[VC alloc] init];
    [viewController setTitle:title];
    
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    [viewController release];
    
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectedImage];
    
    return nav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
