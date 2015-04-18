//
//  ZWMeViewController.m
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWMeViewController.h"

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
}


#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
