//
//  RefreshVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "RefreshVC.h"


@interface RefreshVC () 

@end

@implementation RefreshVC

@synthesize searchBar = _searchBar;
@synthesize mySearchDisplayController = _mySearchDisplayController;

- (void)dealloc
{
    self.searchBar = nil;
    self.headerView = nil;
    self.footerView = nil;
    self.mySearchDisplayController = nil;
    [super dealloc];
}

- (CGRect)getSearchBarFrame {
    return CGRectMake(0, 0, 320, 35);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加搜索框
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    self.searchBar.delegate = self;
    [self.searchBar release];
    
    _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    
    self.navigationItem.leftBarButtonItems = @[searchBarItem];
    self.navigationItem.leftBarButtonItems = [self addBarButtonItems:self.navigationItem.leftBarButtonItems];
    
    //添加刷新视图
    self.headerView = [MJRefreshHeaderView header];
    self.headerView.scrollView = self.tableView;
    
}

- (NSArray *)addBarButtonItems:(NSArray *)leftBarButtonItems {
        NSLog(@"请在子类中重写此方法:%s",__FUNCTION__);
    return leftBarButtonItems;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"请在子类中重写此方法%@", NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
