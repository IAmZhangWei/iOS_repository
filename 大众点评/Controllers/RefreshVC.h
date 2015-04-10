//
//  RefreshVC.h
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "RootVC.h"
#import "MJRefresh.h"

@interface RefreshVC : RootVC <UISearchBarDelegate>

@property (nonatomic, retain) MJRefreshHeaderView *headerView;
@property (nonatomic, retain) MJRefreshFooterView *footerView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *mySearchDisplayController;

- (NSArray *)addBarButtonItems:(NSArray *)leftBarButtonItems;

@end
