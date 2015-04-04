//
//  RefreshVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "RefreshVC.h"
#import "MJRefresh.h"


@interface RefreshVC ()

@property (nonatomic, retain) MJRefreshHeaderView *headerView;
@property (nonatomic, retain) MJRefreshFooterView *footerView;

@end

@implementation RefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加刷新视图
    self.headerView = [MJRefreshHeaderView header];
    self.headerView.scrollView = self.tableView;
    [self.headerView setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //开始刷新
        NSLog(@"开始刷新");
        [self.headerView endRefreshing];
    }];
    [self.headerView setEndStateChangeBlock:^(MJRefreshBaseView *refreshView) {
        //刷新完毕
        NSLog(@"刷新完毕");
    }];
    [self.headerView setRefreshStateChangeBlock:^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        //刷新状态变更时调用
        NSLog(@"刷新状态变更");
    }];
    
    
    
    self.footerView = [MJRefreshFooterView footer];
    self.footerView.scrollView = self.tableView;
    [self.footerView setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //开始刷新
        NSLog(@"开始刷新");
        [self.footerView endRefreshing];
    }];
    [self.footerView setEndStateChangeBlock:^(MJRefreshBaseView *refreshView) {
        //刷新完毕
        NSLog(@"刷新完毕");
    }];
    [self.footerView setRefreshStateChangeBlock:^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        //刷新状态变更时调用
        NSLog(@"刷新状态变更");
    }];
    
}

- (void)dealloc
{
    self.headerView = nil;
    self.footerView = nil;
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
