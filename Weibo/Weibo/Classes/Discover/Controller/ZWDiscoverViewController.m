//
//  ZWDiscoverViewController.m
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWDiscoverViewController.h"
#import "ZWSearchBar.h"

@implementation ZWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZWSearchBar *searchBar = [ZWSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
