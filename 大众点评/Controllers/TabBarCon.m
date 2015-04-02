//
//  TabBarCon.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "TabBarCon.h"
#import "NavC.h"

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
    NavC *mainNav = (NavC *)[self navigationControllerWithViewController:[MainVC class] title:nil image:image andSelectedImage:selectedImage];
    mainNav.title = @"首页";
    
    image = [UIImage imageNamed:@"home_footbar_icon_group@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_group_pressed@3x"];
    NavC *groupNav = (NavC *)[self navigationControllerWithViewController:[GroupVC class] title:nil image:image andSelectedImage:selectedImage];
    groupNav.title = @"团购";
    
    image = [UIImage imageNamed:@"home_footbar_icon_found@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_found_pressed"];
    NavC *discovNav = (NavC *)[self navigationControllerWithViewController:[DiscoveryVC class] title:nil image:image andSelectedImage:selectedImage];
    discovNav.title = @"发现";
    
    image = [UIImage imageNamed:@"home_footbar_icon_my@3x"];
    selectedImage = [UIImage imageNamed:@"home_footbar_icon_my_pressed@3x"];
    UIViewController *mineNav = [self navigationControllerWithViewController:[MineVC class] title:nil image:image andSelectedImage:selectedImage];
    mineNav.title = @"我的";
    
    self.viewControllers = @[mainNav, groupNav, discovNav, mineNav];
    self.tabBar.tintColor = [UIColor orangeColor];

}

- (UINavigationController *)navigationControllerWithViewController:(Class)VC  title:(NSString *)title image:(UIImage *)image andSelectedImage:(UIImage *)selectedImage {
    
    UIViewController *viewController = [[VC alloc] init];
    [viewController setTitle:title];
    
    UINavigationController *nav = nil;
    if ([VC isSubclassOfClass:[MineVC class]]) {
        nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    } else {
        nav = [[NavC alloc] initWithRootViewController:viewController];
    }
    [viewController release];
    
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectedImage];
    
    return nav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
