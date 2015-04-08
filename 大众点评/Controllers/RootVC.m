//
//  RootVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "RootVC.h"

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.tabBarController.tabBar.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.tableView];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"wm_mytakeaway_status_success_bkg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)dealloc
{
    self.tableView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
