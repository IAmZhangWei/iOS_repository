//
//  RootVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()

@property (nonatomic, retain) UITableView *tableView;
@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
