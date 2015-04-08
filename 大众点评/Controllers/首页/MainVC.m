//
//  MainVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//


#import "MainVC.h"
#import "ZKButton.h"
#import "MainPageModel.h"
#import "MainPageCell.h"

#import "DPAPI.h"

@interface MainVC () <UITableViewDelegate, UITableViewDataSource, DPRequestDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, retain) NSMutableArray *models;
@property (nonatomic, assign) NSUInteger page;

@end

@implementation MainVC

@synthesize scrollView = _scrollView;
@synthesize pageControll = _pageControll;
@synthesize models = _models;

- (void)dealloc
{
    self.scrollView = nil;
    self.pageControll = nil;
    self.models = nil;
    [super dealloc];
}

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setTableView];
    
    [self requestData];
    
    [self addRefreshEvent];
}

- (void)addRefreshEvent {
    
    [self.headerView setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //开始刷新
        NSLog(@"开始刷新头部");
        [self requestData];
    }];
    [self.headerView setEndStateChangeBlock:^(MJRefreshBaseView *refreshView) {
        //刷新完毕
        NSLog(@"头部刷新完毕");
    }];
    [self.headerView setRefreshStateChangeBlock:^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        //刷新状态变更时调用
        NSLog(@"头部刷新状态变更");
    }];
    
    
    
    self.footerView = [MJRefreshFooterView footer];
    self.footerView.scrollView = self.tableView;
    [self.footerView setBeginRefreshingBlock:^(MJRefreshBaseView *refreshView) {
        //开始刷新
        NSLog(@"开始刷新尾部");
        self.page++;
        [self requestData];
    }];
    [self.footerView setEndStateChangeBlock:^(MJRefreshBaseView *refreshView) {
        //刷新完毕
        NSLog(@"尾部刷新完毕");
    }];
    [self.footerView setRefreshStateChangeBlock:^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        //刷新状态变更时调用
        NSLog(@"尾部刷新状态变更");
    }];
}

- (void)requestData {
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"city": @"上海", @"category":@"美食", @"latitude":@31.18268013000488, @"longitude":@121.42769622802734, @"sort":@1, @"limit":@20, @"offset_type":@1, @"out_offset_type":@1, @"platform":@2, @"page":[NSNumber numberWithUnsignedInteger:self.page]};
    
    [[DPAPI alloc] requestWithURL:@"v1/business/find_businesses" params:dic delegate:self];
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError:%@", error);
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    NSDictionary *dic = (NSDictionary *)result;
    
    NSArray *arr = dic[@"businesses"];
    for (NSDictionary *dic in arr) {
        MainPageModel *model = [MainPageModel mainPageModelWithDic:dic];
        [self.models addObject:model];
    }
    [self.tableView reloadData];
    
    [self.footerView endRefreshing];
    [self.headerView endRefreshing];
}


#pragma mark --设置tableView
- (void)setTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setTableHeaderView:[self tableHeaderView]];
}

//自定义整个表的头部
- (UIView *)tableHeaderView {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 180)] autorelease];
    
    //设置scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:view.frame];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(view.frame)* 5, 180);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(view.frame), 0);
    [self setButton];
    [view addSubview:self.scrollView];
    
    //设置pageControl
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_scrollView.frame) - 20, self.view.frame.size.width - 50, 20)];
    self.pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControll.numberOfPages = 3;
    self.pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    [view addSubview:self.pageControll];
    
    return view;
}

#pragma mark --添加tableViewDataSource代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"猜你喜欢";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ident = @"cell";
    
    MainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[MainPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark --添加scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //要判断一下 scrollView 是不是 tableView
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        if (scrollView.contentOffset.x == 0) {
            [scrollView setContentOffset:CGPointMake(self.view.frame.size.width * 3, 0) animated:NO];
            _pageControll.currentPage = 2;
            return;
        }
        if (scrollView.contentOffset.x == self.view.frame.size.width * 4) {
            [scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
            _pageControll.currentPage = 0;
            return;
        }
        _pageControll.currentPage = scrollView.contentOffset.x / self.view.frame.size.width - 1;
    }
}

#pragma mark --添加button
- (void)setButton {
    NSArray *imagesArr = @[@"footer", @"scenicspots_o", @"ktv_u", @"shoppingmall", @"vip", @"marry_u", @"food_u", @"",
                           @"food_u", @"snack_u", @"relax", @"more_o", @"groupon_u", @"hotel_u", @"takeaway_u", @"film_u",
                           @"beauty", @"baby", @"marry", @"jiazhuang", @"booking_u", @"discount_u", @"food_u", @"food_u",
                           @"footer", @"scenicspots_o", @"ktv_u", @"shoppingmall", @"vip", @"marry_u", @"food_u", @"",
                           @"food_u", @"snack_u", @"relax", @"more_o", @"groupon_u", @"hotel_u", @"takeaway_u", @"film_u"];
    
    NSArray *titleArr = @[@"足疗按摩", @"周边游", @"KTV", @"购物商城", @"会员卡",@"拍婚照",@"爱车", @"",
                          @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影",
                          @"丽人", @"亲子", @"结婚", @"家装", @"订座", @"找优惠", @"有料", @"看演出",
                          @"足疗按摩", @"周边游", @"KTV", @"购物商城", @"会员卡",@"拍婚照",@"爱车", @"",
                          @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影"];
    
    CGFloat gap = self.view.frame.size.width / 12;
    
    CGFloat btnW = (self.view.frame.size.width - 5 * gap) / 4;
    
    for (int i = 0; i < 5; i++) {//i 表示页数
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollView.frame))];
        [view setBackgroundColor:[UIColor whiteColor]];
        [_scrollView addSubview:view];
        [view release];
        
        for (int j = 0; j < 8; j++) {
            ZKButton *btn = [ZKButton buttonWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), (j / 4) * 70 + 15, btnW, btnW) type:UIButtonTypeCustom title:nil backgroundImage:nil andimage:imagesArr[i * 8 + j] andBlock:^(ZKButton *button) {
                
            }];
            
            UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), CGRectGetMaxY(btn.frame), btnW, 20)];
            titleLabel.text = titleArr[i * 8 + j];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:titleLabel];
            
            [view addSubview:btn];
        }
    }
}

- (NSArray *)addBarButtonItems:(NSArray *)leftBarButtonItems {
    
    //添加左边按钮
    UIImage *leftImage = [[UIImage imageNamed:@"navibar_icon_arrow_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton release];
    
    //添加右边按钮
    UIImage *rightImage = [[UIImage imageNamed:@"Detail_ShareByMail_D"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton release];
    
    return @[leftButtonItem, [leftBarButtonItems lastObject], rightButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
